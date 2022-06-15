// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/read%20data/get_beverage_item_details.dart';
import 'package:stock_app/screen/beverage%20screens/add_beverage_item_screen.dart';

class BeverageItemScreen extends StatefulWidget {
  const BeverageItemScreen({Key? key}) : super(key: key);

  @override
  State<BeverageItemScreen> createState() => _BeverageItemScreenState();
}

class _BeverageItemScreenState extends State<BeverageItemScreen> {
  // to collect ids
  List<String> beverageItemIDs = [];

  // method to get ids
  Future getBeverageItemId() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc('Beverages')
        .collection('drinks')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              beverageItemIDs.add(element.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              // Beverage heading  + add logo
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Beverages',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddBeverageItemScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(225, 229, 242, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0.3,
                              color: Color.fromARGB(255, 129, 129, 131),
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // One item view
              Expanded(
                child: FutureBuilder(
                  future: getBeverageItemId(),
                  builder: (BuildContext context, snapshot) {
                    return ListView.builder(
                      itemCount: beverageItemIDs.length,
                      itemBuilder: (BuildContext context, index) {
                        return GetBeverageItemDetail(
                            beverageItemId: beverageItemIDs[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
