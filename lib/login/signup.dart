import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:restaurant/login/login.dart';
import 'package:restaurant/menus/main_tab.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _miBox = Hive.box('miBox');
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // grabar las preferencias
        _miBox.put('usuario', email);
        _miBox.put('clave', password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainTab()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    double c_acho = MediaQuery.of(context).size.width;
    double c_alto = MediaQuery.of(context).size.height;
    //
    return Scaffold(
      backgroundColor: Color(0xFF8D6E63),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/logorest.png",
                  width: c_acho / 2,
                  height: c_alto / 5,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nuevo usuario",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 26,
                            fontFamily: 'Pacifico'),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFA1887F),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: namecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Nombre',
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFA1887F),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: mailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digíte el correo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Correo',
                              hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFA1887F),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digíte la clave';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Clave',
                              hintStyle: TextStyle(color: Colors.white60)),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              name = namecontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          registration();
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
                              "Registrar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: c_alto / 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Si ya estas registrado",
                      style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic, fontSize: 17),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 230, 226, 42),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
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
