import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/menus/pastas.dart';
import 'package:restaurant/menus/platillos.dart';
import 'package:restaurant/menus/postres.dart';
import 'package:restaurant/menus/carrito.dart';
import 'package:restaurant/menus/splash_model.dart';
import 'package:restaurant/utils/tcolor.dart';
import 'package:restaurant/widgets/icon_text_row.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  //
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    iniciarUser();
    controller = TabController(length: 4, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  iniciarUser() async {
    user = _auth.currentUser!;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    var splashVM = Get.find<SplashModel>();

    return Scaffold(
      key: splashVM.scaffoldKey,
      drawer: Drawer(
          backgroundColor: const Color(0xff10121D),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 240,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: TColor.primaryText.withOpacity(0.03),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/logo.png",
                        width: media.width * 0.17,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        user.email.toString(),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xffC1C0C0), fontSize: 20),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        user.uid,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xffC1C0C0), fontSize: 10),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "328\nSongs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "328\nSongs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "87\nArtists",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          )
                        ],
                      )*/
                    ],
                  ),
                ),
              ),
              IconTextRow(
                title: "Themes",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Ringtone Cutter",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Sleep Timer",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Equalizer",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Driver Mode",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Hidden Folders",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Scan Media",
                icon: "assets/icons/orders.png",
                onTap: () {},
              ),
            ],
          )),
      body: TabBarView(
        controller: controller,
        children: const [
          Platillos(),
          Pastas(),
          Postres(),
          Carrito(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5,
            offset: Offset(0, -3),
          )
        ]),
        child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: const TextStyle(fontSize: 10),
              unselectedLabelColor: TColor.primaryText28,
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              tabs: [
                Tab(
                  text: "Platos",
                  icon: Image.asset(
                    selectTab == 0
                        ? "assets/icons/home_tab.png"
                        : "assets/icons/home_tab_un.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                Tab(
                  text: "Pastas",
                  icon: Image.asset(
                    selectTab == 1
                        ? "assets/icons/songs_tab.png"
                        : "assets/icons/songs_tab_un.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                Tab(
                  text: "Postres",
                  icon: Image.asset(
                    selectTab == 2
                        ? "assets/icons/setting_tab.png"
                        : "assets/icons/setting_tab_un.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                Tab(
                  text: "Carrito",
                  icon: Image.asset(
                    selectTab == 2
                        ? "assets/icons/account.png"
                        : "assets/icons/account.png",
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
