import 'package:flutter/material.dart';
import 'package:restaurant/model/items_model.dart';

class Carrito extends ChangeNotifier {
  Map<String, ItemsModel> _items = {};
  Map<String, ItemsModel> get items {
    return {..._items};
  }

  //
  int get numeroItems {
    return _items.length;
  }

  //
  double get montoTotal {
    var total = 0.0;
    items.forEach(
        (key, elementos) => total += elementos.precio * elementos.cantidad);
    return total;
  }

  //
  void agregarItem(String? id, final String nombre, final String imagen,
      final int precio, final int cantidad) {
    if (_items.containsKey(id)) {
      _items.update(
          id!,
          (old) => ItemsModel(
              id: old.id,
              nombre: old.nombre,
              imagen: old.imagen,
              precio: old.precio,
              cantidad: old.cantidad + 1,
              tiempo: '0min',
              descripcion: 'cero'));
    } else {
      _items.putIfAbsent(
          id!,
          () => ItemsModel(
              id: id,
              nombre: nombre,
              imagen: imagen,
              precio: precio,
              cantidad: 1,
              tiempo: 'omin',
              descripcion: 'no hay'));
    }
  }

  //
  //
  void removerItem(String id) {
    _items.remove(id);
  }

  //
  void incrementarCantItem(String id) {
    if (_items.containsKey(id)) {
      _items.update(
          id!,
          (old) => ItemsModel(
              id: old.id,
              nombre: old.nombre,
              imagen: old.imagen,
              precio: old.precio,
              cantidad: old.cantidad + 1,
              tiempo: 'omin',
              descripcion: 'no hay'));
    }
  }

  //
  void decrementarCantItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.cantidad > 1) {
      _items.update(
          id!,
          (old) => ItemsModel(
              id: old.id,
              nombre: old.nombre,
              imagen: old.imagen,
              precio: old.precio,
              cantidad: old.cantidad - 1,
              tiempo: 'omin',
              descripcion: 'no hay'));
    } else {
      _items.remove(id);
    }
  }

  //
  void removerCarrito() {
    _items = {};
  }
}
