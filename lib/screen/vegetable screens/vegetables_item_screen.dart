// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/read%20data/get_vegetable_item_details.dart';

import 'add_vegetable_item_screen.dart';

class VegetableItemScreen extends StatefulWidget {
  const VegetableItemScreen({Key? key}) : super(key: key);

  @override
  State<VegetableItemScreen> createState() => _VegetableItemScreenState();
}

class _VegetableItemScreenState extends State<VegetableItemScreen> {
  // to collect ids
  List<String> vegetableItemIDs = [];

  // method to get ids
  Future getVegetableItemId() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc('Vegetables')
        .collection('vegetables')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              vegetableItemIDs.add(element.reference.id);
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
                      'Vegetables',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AddVegetablesItemScreen(),
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
                  future: getVegetableItemId(),
                  builder: (BuildContext context, snapshot) {
                    return ListView.builder(
                      itemCount: vegetableItemIDs.length,
                      itemBuilder: (BuildContext context, index) {
                        return GetVegetablesItemDetails(
                            vegetableItemId: vegetableItemIDs[index]);
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
