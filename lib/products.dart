import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/catalog.dart';
import 'package:storeapp/search.dart';
import 'details.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
            'Shopping Zone',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const Search(),
                  ));
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                '  Categories',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const Catalog(title: 'Beauty')));
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/beauty.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Beauty'),
                      ],
                    ), //Beauty
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const Catalog(title: 'Grocery')));
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/grocery.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Grocery'),
                      ],
                    ),
                    //Grocery
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const Catalog(title: 'Tech')));
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/tech.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Electronics&Tech'),
                      ],
                    ), //Tech
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const Catalog(title: 'Fashion')));
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/fashion.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Fashion'),
                      ],
                    ) //Fashion
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '  Featured Products',
                style: TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("General")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (context) => Details(
                                                  title: snapshot
                                                      .data!.docs[index]
                                                      .get('Name'),
                                                  image: snapshot
                                                      .data!.docs[index]
                                                      .get('Image'),
                                                  desc: snapshot
                                                      .data!.docs[index]
                                                      .get('Description'),
                                                  price: snapshot
                                                      .data!.docs[index]
                                                      .get('Price'),
                                                )));
                                  },
                                  child: Container(
                                    width: 180,
                                    height: 164,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]
                                                .get('Image')),
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
                                      child: Text(snapshot.data!.docs[index]
                                          .get('Name')),
                                    )),
                              ],
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
                            child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
