import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/model/items_model.dart';

class PlatilloProvider with ChangeNotifier {
  late ItemsModel itemModel;

  List<ItemsModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    itemModel = ItemsModel(
      imagen: element.get("imagen"),
      nombre: element.get("nombre"),
      descripcion: element.get("descripcion"),
      precio: element.get("precio"),
      id: element.get("id"),
      cantidad: element.get("cantidad"),
      tiempo: element.get("tiempo"),
    );
    search.add(itemModel);
  }

  /////////////// herbsProduct ///////////////////////////////
  List<ItemsModel> herbsProductList = [];

  fatchHerbsProductData() async {
    List<ItemsModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("food").get();

    value.docs.forEach(
      (element) {
        productModels(element);

        newList.add(itemModel);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<ItemsModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  /////////////////// Search Return ////////////
  List<ItemsModel> get gerAllProductSearch {
    return search;
  }
}
