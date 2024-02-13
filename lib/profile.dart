import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/login.dart';
import 'about.dart';
import 'databasehelper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String contact = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= 2; i++) {
      _getData();
    }
  }

  Future<void> _logout() async {
    await SQLHelper.logout();
  }

  Future<void> _getData() async {
    var nm = await SQLHelper.getName();
    var con = await SQLHelper.getContact();
    var add = await SQLHelper.getAddress();

    contact = con.toString().replaceAll(RegExp(r"\p{P}", unicode: true), "");
    address = add.toString().replaceAll(RegExp(r"\p{P}", unicode: true), "");
    name = nm.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String namewithoutbraces =
        name.replaceAll(RegExp(r"\p{P}", unicode: true), "");
    String contact2 = contact.replaceAll("contact", "");
    String address2 = address.replaceAll("address", "");

   // String namewithouterror = namewithoutbraces.replaceAll("name", "");
    return Stack(
      children: [
        Container(
          height: 300,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("images/wallpaper.jpg"), // <-- BACKGROUND IMAGE
          //     fit: BoxFit.cover,
          //   ),
          // ),
          padding:
              const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
          decoration: BoxDecoration(
            color: const Color(0xffff6666),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200)),

            // borderRadius: BorderRadius.circular(150),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xffff6666),
            toolbarHeight: 70,
            title: const Text(
              'Your Profile',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(child: Image.asset('images/profile.png', height: 150)),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            ' Hello!',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(name,
                              style: const TextStyle(
                                  fontSize: 40, color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 25,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const Text(
                            ' Your Contact',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            contact2,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 25,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            ' Your Address',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            address2,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 110,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffff6666)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                        ),
                        onPressed: () {
                          _logout();
                          createToast('Logged Out');
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: 110,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const About()));
                        },
                        child: const Text(
                          'Contact',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void createToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
