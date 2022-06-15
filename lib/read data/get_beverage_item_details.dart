import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetBeverageItemDetail extends StatefulWidget {
  final String beverageItemId;

  const GetBeverageItemDetail({Key? key, required this.beverageItemId})
      : super(key: key);

  @override
  State<GetBeverageItemDetail> createState() => _GetBeverageItemDetailState();
}

class _GetBeverageItemDetailState extends State<GetBeverageItemDetail> {
  final itemPriceController = TextEditingController();

  bool itemAvailable = true;

  @override
  Widget build(BuildContext context) {
    // getting all collections
    CollectionReference beverage = FirebaseFirestore.instance
        .collection('categories')
        .doc('Beverages')
        .collection('drinks');

    Future<void> updateDetails() async {
      FirebaseFirestore.instance
          .collection('categories')
          .doc('Beverages')
          .collection('drinks')
          .doc()
          .update({
        'Item Price': int.parse(itemPriceController.text.trim()),
        'Item Available': itemAvailable,
      }).then(
        (value) => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                'Information Updated!',
                style: GoogleFonts.poppins(),
              ),
            );
          },
        ),
      );
    }

    return FutureBuilder<DocumentSnapshot>(
      future: beverage.doc(widget.beverageItemId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['Item Name'],
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  data['Item Quantity'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                data['Item Quantity'] > 100
                                    ? Text(
                                        ' ml',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    : Text(
                                        ' litres',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 0.4,
                                        color:
                                            Color.fromARGB(255, 129, 129, 131),
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: data['Item Image'] != 'null'
                                      ? Image.network(
                                          data['Item Image'],
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child: Text(
                                            'No Image to display',
                                            style: GoogleFonts.poppins(
                                                fontSize: 13),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stock Left',
                                      style: GoogleFonts.poppins(fontSize: 13),
                                    ),
                                    Text(
                                      data['Item Stock'].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: const Color.fromRGBO(
                                            31, 122, 140, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Change Price',
                                      style: GoogleFonts.poppins(fontSize: 13),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: itemPriceController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Change Availability',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              itemAvailable = true;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Colors.green,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Yes',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 18),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              itemAvailable = false;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'No',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                updateDetails();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(31, 122, 140, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Update',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 100,
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
                child: Row(
                  children: [
                    // item image
                    Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.network(
                        data['Item Image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // item detail
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 7),
                          Text(
                            data['Item Name'],
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                data['Item Quantity'].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              data['Item Quantity'] > 100
                                  ? Text(
                                      ' ml',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  : Text(
                                      ' litres',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          data['Item Available']
                              ? Text(
                                  'Available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.green,
                                  ),
                                )
                              : Text(
                                  'Not Available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ),

                    // item price
                    SizedBox(
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              'Rs. ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['Item Price'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
