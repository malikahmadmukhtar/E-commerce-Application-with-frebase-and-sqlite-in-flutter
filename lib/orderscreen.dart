import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/details.dart';

class OrderScreen extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String username;
  var docid;

  OrderScreen(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.username,
      required this.docid});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int counter = 1;

  void _addOrder(String username, String productname, String image,
      String price, String quantity, String method) {
    CollectionReference users = FirebaseFirestore.instance.collection('orders');
    users.doc('userdata').collection(widget.username).doc().set({
      'username': username,
      'productname': productname,
      'image': image,
      'price': price,
      'quantity': quantity,
      'method': method
    });

    FirebaseFirestore.instance
        .collection('ordermanager')
        .add({
      'username': username,
      'productname': productname,
      'image': image,
      'price': price,
      'quantity': quantity,
      'method': method
    });
  }

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Cash On Delivery';

    var dropdownitems = [
      'Cash On Delivery',
      // 'Credit Card',
      // 'JazzCash',
    ];

    int total = int.parse(widget.price) * counter;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xffff6666),
            toolbarHeight: 70,
            title: const Text(
              'Confirm Order',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(bottom: 30, top: 30, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: screenWidth / 1.5,
                      height: screenHeight / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover),
                          color: Colors.transparent),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rs. ${widget.price}',
                    style: const TextStyle(
                      color: Color(0xffff6666),
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Select Quantity',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (counter > 0) {
                                counter -= 1;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.remove_rounded,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          child: Center(child: Text(counter.toString())),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (counter < 5) {
                                counter += 1;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.add_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Total Price',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rs. $total',
                    style: const TextStyle(
                      color: Color(0xffff6666),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Method of Payment',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: DropdownButton(
                        focusColor: Colors.transparent,
                        // Initial Value
                        value: dropdownvalue,
                        // Down Arrow Icon
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        // Array list of items
                        items: dropdownitems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Delivery Fee',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Rs. 200',
                    style: TextStyle(
                      color: Color(0xffff6666),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffff6666)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                        onPressed: () {
                          showAlertDialog(BuildContext context) {
                            // set up the buttons
                            Widget cancelButton = ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFff6666)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                              ),
                              child: const Text("Cancel",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            );
                            Widget yesButton = ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFff6666)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                              ),
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _addOrder(
                                    widget.username,
                                    widget.title,
                                    widget.image,
                                    total.toString(),
                                    counter.toString(),
                                    dropdownvalue);
                                FirebaseFirestore.instance.runTransaction(
                                    (Transaction myTransaction) async {
                                  await myTransaction.delete(widget.docid);
                                });
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                createToast('Order Confirmed');
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              title: const Text("Confirmation"),
                              content: const Text(
                                  "Would you like to Confirm this Order?"),
                              actions: [
                                cancelButton,
                                yesButton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }

                          showAlertDialog(context);
                        },
                        child: const Text(
                          'Place Order',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
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
