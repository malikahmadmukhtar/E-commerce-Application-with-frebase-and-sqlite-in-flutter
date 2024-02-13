import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(// <-- STACK AS THE SCAFFOLD PARENT
        children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bgpro.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent, //
        appBar: AppBar(
          backgroundColor: const Color(0xffff6666),
          toolbarHeight: 70,
          title: const Text(
            'About Developer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "images/appicon.png",
                  width: 130,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Shopping Zone",
                  style: TextStyle(fontSize: 32, color: Colors.black),
                ),
                const Text(
                  "Made with Flutter",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 5, // Space between underline and text
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black,
                    width: 2.5, // Underline thickness
                  ))),
                  child: const Text(
                    "Developed By",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text(
                  "Ahmad Malik",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 5, // Space between underline and text
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black,
                    width: 2.5, // Underline thickness
                  ))),
                  child: const Text(
                    "Developer Contact",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        var url =
                            Uri.parse("https://facebook.com/mlik.malik.503");
                        launchUrl(url);
                      },
                      child: Image.asset(
                        "images/facebook.png",
                        width: 90,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        var url = Uri.parse("https://wa.me/");//add your number here
                        launchUrl(url);
                      },
                      child: Image.asset(
                        "images/whatsapp.png",
                        width: 90,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        var url =
                            Uri.parse("https://instagram.com/ya_its_ahmad/");
                        launchUrl(url);
                      },
                      child: Image.asset(
                        "images/instagram.png",
                        width: 90,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
