import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant/login/auth_page.dart';
import 'package:restaurant/login/forgotpassword.dart';
import 'package:restaurant/login/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _miBox = Hive.box('miBox');
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  void initState() {
    super.initState();
  }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // grabar las preferencias
      _miBox.put('usuario', email);
      _miBox.put('clave', password);

      // navegar a
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
        (route) => false,
      );

      //Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => HomeQW()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    double jAcho = MediaQuery.of(context).size.width;
    double jAlto = MediaQuery.of(context).size.height;
    //
    return Scaffold(
      //backgroundColor: Color(0xFF283793),
      //backgroundColor: Color(0xFFE9ECEF),
      //backgroundColor: Color(0xFFB0BEC5),
      backgroundColor: Color(0xFF8D6E63),

      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/logorest.png",
                  width: jAcho,
                  height: jAlto / 4,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Bienvenido",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 26,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFA1887F),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    controller: useremailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digíte el correo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Correo',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFA1887F),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    controller: userpasswordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digíte la clave';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        hintText: 'Clave',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 24.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "¿Recordar la clave?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                //
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremailcontroller.text;
                        password = userpasswordcontroller.text;
                      });
                    }
                    userLogin();
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFFf95f3b),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Si no estas registrado",
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          " Registrate",
                          style: TextStyle(
                              color: Color.fromARGB(255, 230, 226, 42),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
