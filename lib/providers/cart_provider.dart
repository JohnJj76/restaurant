import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/model/cart_model.dart';
import 'package:restaurant/model/items_model.dart';

final FirebaseFirestore _firest = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class CartProvider with ChangeNotifier {
  //
  late CartModel productModel;
  //
  double amount = 0;
  Set<ItemsModel> foods = {};
  Map<String, int> quantity = {};
  int itemsLength = 0;

  void addItem(ItemsModel item, int foodQuantity, String idusuario) {
    for (int i = 0; i < foodQuantity; i++) {
      amount += item.precio;
      quantity[item.nombre] == null
          ? quantity[item.nombre] = 1
          : quantity[item.nombre] = quantity[item.nombre]! + 1;
      itemsLength++;
      //

      //
    }
    foods.add(item);
    //agregarOrden(item, foodQuantity);
    //
    notifyListeners();
  }

/////////////// herbsProduct ///////////////////////////////
  List herbsProductList = [];

  fatchHerbsProductData() async {
    //List<CartModel> newList = [];
    List newList = [];

    CollectionReference collectionReference = _firest
        .collection('ordenes')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("misOrdens");

    QuerySnapshot queryPeople = await collectionReference.get();
    queryPeople.docs.forEach((documento) {
      //print(documento['concepto']);
      newList.add(documento.data());
      //listacarrito.add(documento.data());
    });

    herbsProductList = newList;
    notifyListeners();
  }

  List get getHerbsProductDataList {
    return herbsProductList;
  }

//////////////// Fresh Product /////////////////////////////

  // AGREGAR
  Future<void> agregarOrden(CartModel e, int quant) async {
    try {
      await _firest
          .collection('ordenes')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("misOrdens")
          .doc()
          .set(
        {
          "id": e.id,
          "nombre": e.nombre,
          "imagen": e.imagen,
          "precio": e.precio,
          "cantidad": e.cantidad,
          "subTotal": e.cantidad * e.precio,
        },
      );
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> buscarUser(String idusuario) async {
    final snapshot = await _firest.doc('ordenes/${idusuario}').get();
    if (snapshot == null) {}
  }

//per ora si può rimuovere 1 elemento alla volta
  void removeItem(ItemsModel item, {int foodQuantity = 1}) {
    amount -= item.precio;
    quantity[item.nombre] = quantity[item.nombre]! - 1;
    itemsLength--;
    //rimuovo elemento se non ne ho più
    if (quantity[item.nombre] == 0) {
      foods.remove(item);
    }
    notifyListeners();
  }
}
