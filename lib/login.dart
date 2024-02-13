import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeapp/home.dart';
import 'package:storeapp/signup.dart';
import 'databasehelper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final logintext = TextEditingController();
  final passtext = TextEditingController();
  Future<void> _login() async {
    var imm = await SQLHelper.getLogin(logintext.text, passtext.text);
    if (imm == 1) {
      createToast("Welcome");
      SQLHelper.setSession(logintext.text);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const Home()),
      );
    } else {
      createToast("Wrong Info");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg3.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                  //width: double.infinity,
                ),
                const Text(
                  '    Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 30,
                  width: double.infinity,
                ),
                Center(
                  child: Image.asset(
                    'images/login.png',
                    height: 220,
                    // width: 150,
                  ),
                ),
                const SizedBox(height: 90),
                Column(
                  children: [
                    Container(
                        //color: Colors.blue,
                        width: 360,
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 345,
                                child: TextField(
                                  controller: logintext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.contact_mail),
                                    labelText: 'Phone#',
                                    contentPadding: EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  minLines: 1,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 345,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  controller: passtext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.key_rounded),
                                    labelText: 'Password',
                                    contentPadding: EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  minLines: 1,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff1e88e5)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => Signup()));
                            },
                            child: const Text(
                              'Sign-Up',
                              style: TextStyle(fontSize: 20,color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffff6666)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                            ),
                            onPressed: () {
                              _login();
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
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


