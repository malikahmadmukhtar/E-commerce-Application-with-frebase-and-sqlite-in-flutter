import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/databasehelper.dart';
import 'home.dart';
import 'login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffff6666),
      ),
      home: const Main()));
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    var check = await SQLHelper.checkLogin();
    // createToast(check.toString());
    // print(check.toString());
    if (check == 1) {
      createToast('Welcome');
      Timer(
          const Duration(milliseconds: 1500),
          () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  // fullscreenDialog: true,
                  builder: (context) => const Home())));
    } else {
      Timer(
          const Duration(milliseconds: 1500),
          () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  //  fullscreenDialog: true,
                  builder: (context) => const Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFE5F8),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            Image.asset(
              "images/splashtemp.png",
              width: 300,
            ),
            const SizedBox(
              height: 90,
            ),
            // const CircularProgressIndicator(
            //   color: Colors.blueAccent,
            // )
            //const CupertinoActivityIndicator(radius: 12, animating: true),
            LoadingAnimationWidget.inkDrop(color: Colors.black87, size: 20)
          ],
        ),
      ),
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
