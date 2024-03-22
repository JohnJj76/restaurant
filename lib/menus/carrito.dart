import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/login/login.dart';
import 'package:restaurant/menus/splash_model.dart';
import 'package:restaurant/model/cart_model.dart';
import 'package:restaurant/model/items_model.dart';
import 'package:restaurant/providers/cart_provider.dart';
import 'package:restaurant/services/fire_platillos.dart';
import 'package:restaurant/utils/tcolor.dart';

class Carrito extends StatefulWidget {
  const Carrito({super.key});

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final double uz = 0;
  //final CollectionReference _postres = FirebaseFirestore.instance.collection('postres');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: TColor.bg,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.find<SplashModel>().openDrawer();
              },
              icon: Image.asset(
                "assets/icons/menu.png",
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              )),
          title: Text(
            "MI CARRITO",
            style: TextStyle(
                color: TColor.primaryText80,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                    (route) => false,
                  );
                },
                child: Icon(Icons.logout),
              ),
            ),
          ]),
      body: FutureBuilder(
        future: leerCarrito(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 30,
                  height: 80,
                  child: Column(
                    children: [
                      Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            snapshot.data![index]['imagen'],
                            width: 65,
                            height: 55,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            snapshot.data![index]['nombre'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cantidad  ' +
                                    "${snapshot.data![index]['cantidad']}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 134, 95, 95),
                                    fontSize: 14),
                              ),
                              Text(
                                'S.total ' +
                                    "\$ ${(snapshot.data![index]['precio'] * snapshot.data![index]['cantidad']).toStringAsFixed(0)}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 83, 55, 55),
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.orange,
                            ),
                            //remove element from the cart
                            onPressed: () {
                              //CartHandler.removeItem(food);
                              //cart.removeItem(food);
                            },
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  //

                  //
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Total Pagar : " + uz.toString()),
        icon: Icon(Icons.shopping_cart),
        onPressed: () {},
      ),

      /*
      body: Consumer<CartProvider>(
        builder: (context, listacarrito, _) {
          if (listacarrito.itemsLength == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/carrito_vacio.png"),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: Text("El carrito esta vacío")),
                const Spacer()
              ],
            );
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //list with orders in the cart
                
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    children: listacarrito
                        .map((listac) => _buildFoodBox(context, food, cartProv))
                        .toList(),
                  ),
                ),
                //button for order products
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total: \$ ${cartProv.amount.toStringAsFixed(2)}"),
                        const Spacer(),
                        const Text("Mi Orden "),
                        GestureDetector(
                            onTap: () async {
                              final link = WhatsAppUnilink(
                                phoneNumber: '+57-(301)3712298',
                                text:
                                    "Hey! I'm inquiring about the apartment listing",
                              );
                              // Convert the WhatsAppUnilink instance to a string.
                              // Use either Dart's string interpolation or the toString() method.
                              // The "launchUrlString" method is part of "url_launcher_string".
                              await launchUrlString('$link');
                            },
                            /*
                              //enviar a wasap
                              String pedido = "este es mi pedido";
                              //
                              String celular = "0573013712298";
                              String mensaje = pedido;
                              String url =
                                  "whatsapp://send?phone=$celular&text=$mensaje";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw ('mensaje no enviado');
                              }
                              */

                            child: const Icon(Icons.shopify))
                      ],
                    ),
                  ),
                ),
              
              ]);
        },
      ),
      */
    );
  }
}

Widget _buildFoodBox(BuildContext context, ItemsModel food, CartProvider cart) {
  final int foodQuantity = cart.quantity[food.nombre]!;
  final double foodAmount = (food.precio * foodQuantity) as double;
  return Card(
    elevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      leading: Image.network(food.imagen),
      title: Text(
        food.nombre,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cantidad ' + "${cart.quantity[food.nombre]}",
            style: const TextStyle(color: Color(0xFFC4C4C4), fontSize: 16.0),
          ),
          Text(
            'Subtotal ' + "\$ ${foodAmount.toStringAsFixed(0)}",
            style: const TextStyle(color: Color(0xFFC4C4C4), fontSize: 16.0),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.orange,
        ),
        //remove element from the cart
        onPressed: () {
          //CartHandler.removeItem(food);
          cart.removeItem(food);
        },
      ),
    ),
  );
}
