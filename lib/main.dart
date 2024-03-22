import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/firebase_options.dart';
import 'package:restaurant/menus/splash.dart';
import 'package:restaurant/providers/cart_provider.dart';
import 'package:restaurant/utils/tcolor.dart';

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff746bc9),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await Hive.initFlutter();
  var box = await Hive.openBox('miBox');
  //

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        /*ChangeNotifierProvider<PlatilloProvider>(
          create: (context) => PlatilloProvider(),
        ),*/
      ],
      child: GetMaterialApp(
        title: 'Restaurante',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Circular Std",
          scaffoldBackgroundColor: TColor.darkGray,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: TColor.primaryText,
                displayColor: TColor.primaryText,
              ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: TColor.primary,
          ),
          useMaterial3: false,
        ),
        home: const Splash(),
      ),
    );
  }
}
