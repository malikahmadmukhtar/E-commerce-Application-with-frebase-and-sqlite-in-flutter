import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:storeapp/orders.dart';
import 'package:storeapp/products.dart';
import 'package:storeapp/profile.dart';
import 'cart.dart';
import 'databasehelper.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int cartitems = 0;

class _HomeState extends State<Home> {
  var currentIndex = 0;

  String username = '';
  Future<void> _getname() async {
    var nm = await SQLHelper.getName();
    username = nm.toString();
    cartitems = await FirebaseFirestore.instance
        .collection("cart")
        .doc('userdata')
        .collection(username)
        .get()
        .then((value) => value.size);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      _getname();
    }
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    var pages = [
      const Products(),
      Cart(username: username),
      Orders(username: username),
      const Profile()
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 8, top: 7),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFAF9F6),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: const Color(0xffff6666).withOpacity(0.6),
                  hoverColor: const Color(0xffff6666).withOpacity(0.6),
                  gap: 3,
                  tabActiveBorder:
                      Border.all(color: const Color(0xffff6666), width: 2),
                  activeColor: const Color(0xffff6666),
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.white,
                  color: const Color(0xffff6666),
                  tabs: [
                    const GButton(
                      icon: Icons.home_rounded,
                      text: 'Home ',
                    ),
                    GButton(
                      icon: Icons.shopping_cart_rounded,
                      //iconColor: Colors.white,
                      leading: badges.Badge(
                        badgeContent: Text(
                          cartitems.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Icon(Icons.shopping_cart_rounded,
                            color: Color(0xffff6666)),
                      ),
                      text: ' Cart',
                    ),
                    const GButton(
                      icon: Icons.shopping_bag_rounded,
                      text: 'Orders',
                    ),
                    const GButton(
                      icon: Icons.person_rounded,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: currentIndex,
                  onTabChange: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
