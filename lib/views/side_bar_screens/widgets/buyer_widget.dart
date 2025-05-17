import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_app_admin_panel/controllers/buyer_controller.dart';
import 'package:web_app_admin_panel/models/buyer.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<BuyerWidget> {
  late Future<List<BuyerModel>> futureBuyers;

  @override
  void initState() {
    super.initState();
    futureBuyers = BuyerController().fetchBuyers();
  }

  @override
  Widget build(BuildContext context) {
    Widget _BuyerData(int flex, Widget widget) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      );
    }

    return FutureBuilder<List<BuyerModel>>(
      future: futureBuyers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Buyers'));
        } else {
          final buyers = snapshot.data!;

          return SizedBox(
            height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                final buyer = buyers[index];
                // print(buyer.username);
                final avatarLetter = (buyer.username.isNotEmpty)
                    ? buyer.username[0].toUpperCase()
                    : '?';

                return Column(
                  children: [
                    Row(
                      children: [
                        _BuyerData(
                          1,
                          CircleAvatar(
                            child: Text(
                              avatarLetter,
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        _BuyerData(
                          2,
                          Text(
                            buyer.username,
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _BuyerData(
                          2,
                          Text(
                            buyer.email,
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _BuyerData(
                          2,
                          Text(
                            '${buyer.city}, ${buyer.state}',
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _BuyerData(
                          1,
                          TextButton(
                            onPressed: () {
                              // Add your delete logic here
                            },
                            child: Text(
                              'Delete',
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}