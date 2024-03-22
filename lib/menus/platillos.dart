import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:restaurant/login/login.dart';
import 'package:restaurant/menus/detalles/detail_page.dart';
import 'package:restaurant/menus/splash_model.dart';
import 'package:restaurant/model/items_model.dart';
import 'package:restaurant/utils/tcolor.dart';

class Platillos extends StatefulWidget {
  const Platillos({super.key});

  @override
  State<Platillos> createState() => _PlatillosState();
}

class _PlatillosState extends State<Platillos> {
  //
  final CollectionReference _platillos =
      FirebaseFirestore.instance.collection('food');
  final _miBox = Hive.box('miBox');
  //

  @override
  Widget build(BuildContext context) {
    //
    double zancho = MediaQuery.of(context).size.width;
    double zalto = MediaQuery.of(context).size.height;
    String sNombre;
    //
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
            "PLATILLOS",
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
                  _miBox.delete('usuario');
                  _miBox.delete('clave');
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            //
            const SizedBox(height: 5),
            //
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                  stream: _platillos.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 260,
                          ),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            //
                            sNombre = documentSnapshot['nombre'];
                            int nCaracteres = sNombre.length;
                            if (nCaracteres >= 14) {
                              sNombre = (documentSnapshot['nombre']
                                      .substring(0, 11)) +
                                  "...";
                            } else {
                              sNombre = documentSnapshot['nombre'];
                            }
                            //

                            return GestureDetector(
                              onTap: () {
                                ItemsModel platillo = ItemsModel(
                                  id: documentSnapshot['id'],
                                  nombre: documentSnapshot['nombre'],
                                  imagen: documentSnapshot['imagen'],
                                  precio: documentSnapshot['precio'],
                                  tiempo: documentSnapshot['tiempo'],
                                  descripcion: documentSnapshot['descripcion'],
                                  cantidad: 0,
                                );

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PastaDetalle(food: platillo);
                                }));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 182, 104, 104),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(120),
                                            child: Image.network(
                                              documentSnapshot['imagen'],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            sNombre,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.watch_later,
                                                color: Color.fromARGB(
                                                    255, 192, 186, 186),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                documentSnapshot['tiempo'],
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 192, 186, 186)),
                                              ),
                                              const Spacer(),
                                              const Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 16),
                                              const SizedBox(width: 2),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .account_balance_wallet_rounded,
                                                color: Color.fromARGB(
                                                    255, 192, 186, 186),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '\$${documentSnapshot['precio']}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Icon(Icons.favorite_border,
                                          color: Colors.grey),
                                    ),
                                    const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Material(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        child: InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.add,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return Container();
                  }),
            ),

            //
            //
            //
          ],
        ),
      ),
    );
  }
}
