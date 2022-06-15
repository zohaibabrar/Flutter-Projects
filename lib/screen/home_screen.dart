// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/screen/beverage%20screens/beverage_item_screen.dart';
import 'package:stock_app/screen/confectionery%20screens/confectionery_item_screen.dart';
import 'package:stock_app/screen/dry%20fruits%20screens/dry_fruits_item_screen.dart';
import 'package:stock_app/screen/frozen%20food%20screens/frozen_food_item_screen.dart';
import 'package:stock_app/screen/skin%20care%20screens/skin_care_item_screen.dart';
import 'package:stock_app/screen/soap%20screens/soap_item_screen.dart';
import 'package:stock_app/screen/vegetable%20screens/vegetables_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sign out button

            // 'Update products very easily' => container with previous color
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: const Color.fromRGBO(31, 122, 140, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: MediaQuery.of(context).size.height * 0.13,
                    ),
                    child: Text(
                      'Update products \nvery easily!',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child: GestureDetector(
                      onTap: () => FirebaseAuth.instance.signOut(),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Select Category title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Category',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Error!',
                          style: GoogleFonts.poppins(),
                        ),
                        content: Text(
                          'Adding categories is not assigned yet.',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // List View, scrollable at fixed height with item's categories
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(225, 229, 242, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BeverageItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/3081/3081866.png'),
                              title: Text(
                                'Beverages',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ConfectioneryItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://pic.onlinewebfonts.com/svg/img_549787.png'),
                              title: Text(
                                'Confectionery',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DryFruitsItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/3827/3827915.png'),
                              title: Text(
                                'Dry Fruits',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FrozenFoodItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://thumbs.dreamstime.com/z/frozen-food-icon-supermarket-shopping-mall-related-vector-illustration-216865845.jpg'),
                              title: Text(
                                'Frozen Foods',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SkinCareItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/2025/2025324.png'),
                              title: Text(
                                'Skin Care',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SoapItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/2553/2553628.png'),
                              title: Text(
                                'Soap & Detergents',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const VegetableItemScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/4163/4163704.png'),
                              title: Text(
                                'Vegetables',
                                style: GoogleFonts.poppins(fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
