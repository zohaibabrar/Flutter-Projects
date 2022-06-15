// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/read%20data/get_soap_item_details.dart';

import 'add_soap_item_screen.dart';

class SoapItemScreen extends StatefulWidget {
  const SoapItemScreen({Key? key}) : super(key: key);

  @override
  State<SoapItemScreen> createState() => _SoapItemScreenState();
}

class _SoapItemScreenState extends State<SoapItemScreen> {
  // to collect ids
  List<String> soapItemIDs = [];

  // method to get ids
  Future getSoapItemId() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc('Soap & Detergents')
        .collection('soap')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              soapItemIDs.add(element.reference.id);
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
                      'Soap & Detergents',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddSoapItemScreen(),
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
                  future: getSoapItemId(),
                  builder: (BuildContext context, snapshot) {
                    return ListView.builder(
                      itemCount: soapItemIDs.length,
                      itemBuilder: (BuildContext context, index) {
                        return GetSoapItemDetails(
                            soapItemId: soapItemIDs[index]);
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
