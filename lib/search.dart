import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String dropdownvalue = 'General';
  String search = '';

  var items = ['General', 'Tech', 'Fashion', 'Grocery', 'Beauty'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bgpro.jpg"),
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
              'Search for Item',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 16),
                    child: SizedBox(
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        obscureText: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Search',
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
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Choose Category',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    DropdownButton(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      focusColor: Colors.transparent,
                      value: dropdownvalue,
                      icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                      items: items.map((String items) {
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
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection(dropdownvalue)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SearchList> data = snapshot.data!.docs
                            .map((doc) => SearchList(
                                name: doc['Name'],
                                image: doc['Image'],
                                description: doc['Description'],
                                price: doc['Price']))
                            .toList();
                        data = data
                            .where((s) => s.name
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 10),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              if (true) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(CupertinoPageRoute(
                                                builder: (context) => Details(
                                                      title: data[index].name,
                                                      image: data[index].image,
                                                      desc: data[index]
                                                          .description,
                                                      price: data[index].price,
                                                    )));
                                      },
                                      child: Container(
                                        width: 170,
                                        height: 160,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data[index].image),
                                                fit: BoxFit.cover),
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        height: 19,
                                        width: 180,
                                        child: Center(
                                          child: Text(data[index].name),
                                        )),
                                  ],
                                );
                              }
                            });
                      }
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return const Center(
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchList {
  final String name, image, description, price;

  SearchList(
      {required this.name,
      required this.image,
      required this.description,
      required this.price});
}
