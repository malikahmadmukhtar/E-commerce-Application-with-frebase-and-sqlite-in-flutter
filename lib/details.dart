import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cart.dart';
import 'databasehelper.dart';

class Details extends StatefulWidget {
  final String title;
  final String image;
  final String desc;
  final String price;

  const Details(
      {super.key,
      required this.title,
      required this.image,
      required this.desc,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      _getname();
    }
  }

  String username = '';

  Future<void> _getname() async {
    var nm = await SQLHelper.getName();
    username = nm.toString();
  }

  void _addCart(
    String productname,
    String image,
    String price,
  ) {
    CollectionReference users = FirebaseFirestore.instance.collection('cart');
    users.doc('userdata').collection(username).doc().set({
      'name': productname,
      'image': image,
      'price': price,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6666),
        toolbarHeight: 70,
        title: const Text(
          'View Product',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.shopping_cart_rounded,color: Colors.white),
              padding: const EdgeInsets.only(right: 20),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => Cart(
                    username: username,
                  ),
                ));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffff6666),
        foregroundColor: Colors.white,
        onPressed: () {
          _addCart(widget.title, widget.image, widget.price);
          createToast('Added to Cart');
        },
        icon: const Icon(Icons.add_shopping_cart_rounded),
        label: const Text('Add to Cart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: Image.network(
                      widget.image.toString(),
                      height: 340,
                      width: 350,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rs. ${widget.price}',
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              color: Colors.deepOrangeAccent),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Winter Deal',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Standard Delivery\nRs. 150',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10,right: 10),
                    width: 350,
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
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.desc,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                      ],
                    )),
              ],
            )),
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
