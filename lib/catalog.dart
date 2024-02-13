import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/details.dart';

class Catalog extends StatefulWidget {
  final String title;

  const Catalog({super.key, required this.title});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(widget.title)
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
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => Details(
                                            title: snapshot.data!.docs[index]
                                                .get('Name'),
                                            image: snapshot.data!.docs[index]
                                                .get('Image'),
                                            desc: snapshot.data!.docs[index]
                                                .get('Description'),
                                            price: snapshot.data!.docs[index]
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
                                      color: Colors.white.withOpacity(0.6)),
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
                                          .get('Name')))),
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
    ]);
  }
}
