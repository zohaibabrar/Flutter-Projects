import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFrozenFoodItemScreen extends StatefulWidget {
  const AddFrozenFoodItemScreen({Key? key}) : super(key: key);

  @override
  State<AddFrozenFoodItemScreen> createState() =>
      _AddFrozenFoodItemScreenState();
}

class _AddFrozenFoodItemScreenState extends State<AddFrozenFoodItemScreen> {
  bool itemAvaialble = true;
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _itemQuantityController = TextEditingController();

  Future addFrozenFoodItemDetails(String itemName, int itemPrice,
      bool itemAvailable, int itemQuantity) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc('Frozen Foods')
        .collection('frozen foods')
        .add(
      {
        'Item Available': itemAvaialble,
        'Item Name': itemName,
        'Item Price': itemPrice,
        'Item Quantity': itemQuantity,
        'Item Image': 'null',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(31, 122, 140, 1),
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              // back color container
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(31, 122, 140, 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05,
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Text(
                    'Add \nFrozen Food',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),

              // item details column container
              Center(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 130),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Color.fromARGB(255, 81, 81, 83),
                                    offset: Offset(0, 10),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  // Item Name
                                  TextField(
                                    controller: _itemNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Item Name',
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Item Price
                                  TextField(
                                    controller: _itemPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Item Price',
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Item Available
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Item Available: ',
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemAvaialble = true;
                                                  Fluttertoast.showToast(
                                                    msg: 'Yes Choosen!',
                                                    backgroundColor:
                                                        Colors.black,
                                                    timeInSecForIosWeb: 2,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                  );
                                                });
                                              },
                                              child: SizedBox(
                                                child: Text(
                                                  'Yes',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  itemAvaialble = false;
                                                  Fluttertoast.showToast(
                                                    msg: 'No Choosen!',
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            31, 122, 140, 1),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                  );
                                                });
                                              },
                                              child: SizedBox(
                                                child: Text(
                                                  'No',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Item Quantity
                                  TextField(
                                    controller: _itemQuantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Item Quantity',
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Uploading Image
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'No Photo!',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text(
                                                'Sorry!',
                                                style: GoogleFonts.poppins(),
                                              ),
                                              content: Text(
                                                'Uploading image will shortly be enabled.',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.upload,
                                              color: Colors.blue,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'Upload Image',
                                              style: GoogleFonts.poppins(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Add Button
                                  GestureDetector(
                                    onTap: () {
                                      addFrozenFoodItemDetails(
                                        _itemNameController.text.trim(),
                                        int.parse(
                                            _itemPriceController.text.trim()),
                                        itemAvaialble,
                                        int.parse(_itemQuantityController.text
                                            .trim()),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(31, 122, 140, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Add Item',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
