import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  final String username;
  const Orders({super.key, required this.username});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
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
              'Orders',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
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
                          .collection("ordermanager")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<LoadOrder> data = snapshot.data!.docs
                              .map((doc) => LoadOrder(
                                  username: doc['username'],
                                  pname: doc['productname'],
                                  pimage: doc['image'],
                                  method: doc['method'],
                                  price: doc['price'],
                                  quantity: doc['quantity']))
                              .toList();
                          data = data
                              .where((s) =>
                                  s.username.toLowerCase() ==
                                  widget.username.toLowerCase())
                              .toList();
                          return ListView.builder(
                              itemExtent: 150.0,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                // if (snapshot.data!.docs[index]
                                //         .get('username')
                                //         .toString() ==
                                //     widget.username) {
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
                                                  image: NetworkImage(
                                                      data[index].pimage),
                                                  fit: BoxFit.cover),
                                              color: Colors.transparent),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                data[index].pname,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Quantity ' +
                                                  data[index].quantity,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              data[index].method,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Total Rs. ' + data[index].price,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      Colors.deepOrangeAccent),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                // } else {
                                //   return const Center(child: Text('sss'));
                                // }
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

class LoadOrder {
  final String pname, pimage, quantity, price, method, username;

  LoadOrder(
      {required this.username,
      required this.pname,
      required this.pimage,
      required this.quantity,
      required this.price,
      required this.method});
}
