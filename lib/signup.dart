import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'databasehelper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  void createUser(
    String name,
    String address,
    String contact,
  ) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({
      'name': name,
      'address': address,
      'contact': contact,
    });
  }

  Future<void> _addItem() async {
    String username = "${fnametext.text} ${lnametext.text}";
    await SQLHelper.createItem(username, passtext.text.trim(),
        addresstext.text.trim(), contacttext.text.trim());
    createToast("Sign-up\nSucessfull");
  }

  final fnametext = TextEditingController();
  final lnametext = TextEditingController();
  final passtext = TextEditingController();
  final cpasstext = TextEditingController();
  final addresstext = TextEditingController();
  final contacttext = TextEditingController();

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
                  '    Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'images/signup.png',
                    height: 240,
                    // width: 150,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                        //color: Colors.blue,
                        width: 360,
                        height: 340,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 170,
                                    child: TextField(
                                      controller: fnametext,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        labelText: 'First name',
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 170,
                                    child: TextField(
                                      controller: lnametext,
                                      decoration: const InputDecoration(
                                        // prefixIcon: Icon(Icons.person),
                                        labelText: 'Last name',
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
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 345,
                                child: TextField(
                                  obscureText: true,
                                  controller: passtext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.key),
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
                              SizedBox(
                                width: 345,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  controller: cpasstext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.key_rounded),
                                    labelText: 'Confirm Password',
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
                                  obscureText: false,
                                  controller: addresstext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.add_location_sharp),
                                    labelText: 'Address',
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
                                  obscureText: false,
                                  controller: contacttext,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.contact_mail),
                                    labelText: 'Contact#',
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
                            ],
                          ),
                        )),
                    const SizedBox(height: 30),
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
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Back',
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
                              String username =
                                  '${fnametext.text} ${lnametext.text}';
                              if (passtext.text == cpasstext.text) {
                                createUser(username, addresstext.text,
                                    contacttext.text);
                                _addItem();
                                //createToast('Upload');
                              } else {
                                createToast('Passwords Do not Match');
                              }
                              // Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign-Up',
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
