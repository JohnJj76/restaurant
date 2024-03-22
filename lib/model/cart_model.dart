import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? id;
  final String nombre;
  final String imagen;
  final String descripcion;
  final int precio;
  final int cantidad;
  CartModel(
      {this.id,
      required this.nombre,
      required this.imagen,
      required this.descripcion,
      required this.precio,
      required this.cantidad});

  factory CartModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CartModel(
        id: snapshot["id"],
        nombre: snapshot["nombre"],
        imagen: snapshot["imagen"],
        descripcion: snapshot["descripcion"],
        precio: snapshot["precio"].toInt(),
        cantidad: snapshot["cantidad"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "descripcion": descripcion,
        "precio": precio,
        "cantidad": cantidad
      };
}
