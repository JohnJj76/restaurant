import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/model/items_model.dart';

//
final FirebaseFirestore _firest = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
//

// LEER
Future<List> leerCarrito() async {
  double gtotal = 0;
  List listaca = [];
  CollectionReference collectionReference = _firest
      .collection('ordenes')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("misOrdens");

  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    //print(documento['concepto']);
    listaca.add(documento.data());
    print(documento['precio']);
    gtotal += documento['precio'];
  });
  return listaca;
}

// LEER
Future<List> listarFoood() async {
  List listafood = [];
  CollectionReference collectionReference = _firest.collection('food');
  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    //print(documento['concepto']);
    listafood.add(documento.data());
  });
  return listafood;
}

//
// AGREGAR
Future<void> agregarQr(ItemsModel itModel) async {
  final ordenCollection = FirebaseFirestore.instance.collection("ordenes");
  final uid = ordenCollection.doc().id;
  try {
    await _firest.collection('ordenes').add({
      'id': uid,
      'nombre': itModel.nombre,
      'descripcion': itModel.descripcion,
      'imagen': itModel.imagen,
      'precio': itModel.precio,
      'tiempo': itModel.tiempo,
      'cantidad': itModel.cantidad,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}



/*
//LEER
// ok ok ok este funciona exelentemente filtra los registros cullo numero de fra
// es igual a 123
Future<List> listaporParametro() async {
  List listaqr = [];
  QuerySnapshot snapshot =
      await fst.collection('qreros').where('factura', isEqualTo: 123).get();
  snapshot.docs.forEach((f) {
    //if (f['email'] ==email) {
    //  result =true;
    //}
    listaqr.add(f.data());
  });
  return listaqr;
}

Future<List> listaporParametrox() async {
  var date = DateTime.now();
  List listaqr = [];
  QuerySnapshot snapshot = await fst
      .collection('qreros')
      .where('fecha',
          isGreaterThanOrEqualTo: new DateTime(date.year, date.month, 1))
      .orderBy('fecha', descending: true)
      .get();
  snapshot.docs.forEach((f) {
    if (f['revisado'] == false) {
      listaqr.add(f.data());
    }
  });
  return listaqr;
}

// LEER
Future<List> listarQrAP() async {
  List listaqr = [];
  CollectionReference collectionReference = _firestore.collection('qreros');
  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    //listaqr.add(documento.data());
    if (documento['revisado'] == true) {
      listaqr.add(documento.data());
    }
  });
  return listaqr;
}

// filtrado por fecha
Future<List> listarQrPorFecha() async {
  const xprincipio = "01/01/2024";
  const xfinal = "31/01/2024";
  //
  Timestamp myFechaData;
  DateTime cFecha;
  var miFecha;

  List listaqr = [];
  CollectionReference collectionReference = _firestore.collection('qreros');
  QuerySnapshot queryPeople = await collectionReference.get();

  queryPeople.docs.forEach((documento) {
    //******* */
    myFechaData = documento['fecha'];
    cFecha = myFechaData.toDate();
    miFecha = DateFormat('dd/MM/yyyy').format(cFecha);
    print(miFecha);
    //******* */

    if (documento['revisado'] == true &&
        miFecha >= xprincipio &&
        miFecha <= xfinal) {
      listaqr.add(documento.data());
    }

    //final DateTime now = DateTime.now();
  });
  return listaqr;
}
//

//
// AGREGAR
Future<void> agregarQr(QrModel qrModel) async {
  final prodCollection = FirebaseFirestore.instance.collection("qreros");
  final uid = prodCollection.doc().id;
  try {
    await _firestore.collection('qreros').add({
      'id': uid,
      'fecha': qrModel.fecha,
      'concepto': qrModel.concepto,
      'factura': qrModel.factura,
      'valor': qrModel.valor,
      'revisado': qrModel.revisado,
      'empleado': qrModel.empleado,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

// Actualizar un name en base de datos
Future<void> updatePeople(String uid, String name) async {
  await _firestore.collection('todos').doc(uid).update({
    'finished': name,
  });
}

//
// EDITAR
Future<void> editarQr(String uid, QrModel qrModel) async {
  try {
    await _firestore.collection('qreros').doc(uid).update({
      'fecha': qrModel.fecha,
      'concepto': qrModel.concepto,
      'factura': qrModel.factura,
      'valor': qrModel.valor,
      'revisado': qrModel.revisado,
      'empleado': qrModel.empleado,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

//
// EDITAR revisado
Future<void> revisadoQr(String uid) async {
  try {
    await _firestore.collection('qreros').doc(uid).update({
      'revisado': true,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

//
// EDITAR revisado
Future<void> regresarQr(String uid) async {
  try {
    await _firestore.collection('qreros').doc(uid).update({
      'revisado': false,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

//
// BORRAR
Future<void> eliminarQr(String uid) async {
  try {
    await _firestore.collection('qreros').doc(uid).delete();
  } catch (err) {
    print(err);
    rethrow;
  }
}
*/