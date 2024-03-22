import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel {
  String? id;
  final String nombre;
  final String imagen;
  final String tiempo;
  final String descripcion;
  final int precio;
  final int cantidad;
  ItemsModel(
      {this.id,
      required this.nombre,
      required this.imagen,
      required this.tiempo,
      required this.descripcion,
      required this.precio,
      required this.cantidad});

  factory ItemsModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ItemsModel(
        id: snapshot["id"],
        nombre: snapshot["nombre"],
        imagen: snapshot["imagen"],
        descripcion: snapshot["descripcion"],
        tiempo: snapshot["tiempo"],
        precio: snapshot["precio"].toInt(),
        cantidad: snapshot["cantidad"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "descripcion": descripcion,
        "tiempo": tiempo,
        "precio": precio,
        "cantidad": cantidad
      };
}
