import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/model/cart_model.dart';
import 'package:restaurant/model/items_model.dart';
import 'package:restaurant/providers/cart_provider.dart';

class PastaDetalle extends StatefulWidget {
  const PastaDetalle({
    super.key,
    required this.food,
  });
  final ItemsModel food;

  @override
  State<PastaDetalle> createState() => _PastaDetalleState();
}

class _PastaDetalleState extends State<PastaDetalle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  //
  int quantity = 1;
  //int quantity = 0;

  @override
  void initState() {
    super.initState();
    iniciarUser();
  }

  iniciarUser() async {
    user = _auth.currentUser!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          header(),
          const SizedBox(height: 20),
          image(),
          details(),
        ],
      ),
    );
  }

  Container details() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text('\$${widget.food.precio}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        )),
                  ],
                ),
              ),
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          quantity -= 1;
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.white),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$quantity',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () {
                        quantity += 1;
                        setState(() {});
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              const Spacer(),
              const Icon(Icons.fiber_manual_record, color: Colors.red),
              const SizedBox(width: 4),
              const Spacer(),
              const Icon(Icons.access_time_filled, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                widget.food.tiempo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'acerca de la pasta',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.food.descripcion,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 30),
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // AGREGAR AL CARRITO
                if (quantity > 0) {
                  CartModel qr = CartModel(
                    id: widget.food.id,
                    nombre: widget.food.nombre,
                    descripcion: widget.food.descripcion,
                    imagen: widget.food.imagen,
                    precio: int.parse(widget.food.precio.toString()),
                    cantidad: quantity,
                  );
                  // ToDO: Adding a studen
                  /*context
                      .read<CartProvider>()
                      .addItem(widget.food, quantity, user.uid);*/
                  context.read<CartProvider>().agregarOrden(qr, quantity);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(_buildSnackBar(context));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(_buildSnackBar(context, haveError: true));
                }
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: const Text(
                  'Agregar al Carrito',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[300]!,
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(250),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Image.network(
                  widget.food.imagen,
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: const BackButton(color: Colors.white),
          ),
          const Spacer(),
          Text(
            'Detalles de Comida',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.favorite_border, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

SnackBar _buildSnackBar(BuildContext context, {bool haveError = false}) =>
    SnackBar(
      //on tap => open cartPage
      backgroundColor: haveError ? Colors.red : Color(0xFF34C759),
      duration: const Duration(milliseconds: 1500),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            haveError
                ? "La cantidad debe ser mayor que cero."
                : "Agregado al carrito correctamente.",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          if (!haveError)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "cart",
                  (route) => false,
                );
              },
              child: const Text("Open Cart"),
            )
        ],
      ),
    );
