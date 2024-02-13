// ignore_for_file: sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/orderscreen.dart';

import 'details.dart';

class Cart extends StatefulWidget {
  final String username;
  const Cart({super.key, required this.username});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/wallpaper.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xffff6666),
            toolbarHeight: 70,
            title: const Text(
              'Your Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400,color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("cart")
                          .doc('userdata')
                          .collection(widget.username)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemExtent: 150.0,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 125,
                                          height: 125,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data!.docs[index]
                                                      .get('image')),
                                                  fit: BoxFit.cover),
                                              color: Colors.transparent),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              height: screenHeight / 11,
                                              width: screenWidth * 0.5,
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    .get('name'),
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  width: screenWidth / 3,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xffff6666)),
                                                      shape: MaterialStateProperty
                                                          .all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      )),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          CupertinoPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      OrderScreen(
                                                                        title: snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .get(
                                                                                'name'),
                                                                        price: snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .get(
                                                                                'price'),
                                                                        image: snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .get(
                                                                                'image'),
                                                                        username:
                                                                            widget
                                                                                .username,
                                                                        docid: snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .reference,
                                                                      )));
                                                    },
                                                    child: const Text(
                                                      'Order now',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    //Transaction to delete Product
                                                    FirebaseFirestore.instance
                                                        .runTransaction((Transaction
                                                            myTransaction) async {
                                                      await myTransaction.delete(
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                              .reference);
                                                    });
                                                    createToast('Item Removed');
                                                  },
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.black),
                                                  iconSize: 25,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return const Center(
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  color: Color(0xffff6666),
                                )),
                          );
                        }
                      },
                    ),
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
