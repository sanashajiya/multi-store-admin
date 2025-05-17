import 'package:web_app_admin_panel/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/vendor_controller.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  late Future<List<VendorModel>> futureVendors;

  @override
  void initState() {
    super.initState();
    futureVendors = VendorController().fetchVendors();
  }

  @override
  Widget build(BuildContext context) {
    Widget _VendorData(int flex, Widget widget) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      );
    }

    return FutureBuilder(
        future: futureVendors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error:${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Banner'),
            );
          } else {
            final vendors = snapshot.data!;

            return SizedBox(
              height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            _VendorData(
                              1,
                              CircleAvatar(
                                child: Text(
                                  vendor.username[0],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            _VendorData(
                              2,
                              Text(
                                vendor.username,
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _VendorData(
                              2,
                              Text(
                                vendor.email,
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _VendorData(
                              2,
                              Text(
                                '${vendor.city}, ${vendor.state}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _VendorData(
                              1,
                              TextButton(
                                onPressed: () {},
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
                        Divider(),
                      ],
                    );
                  }),
            );
          }
        });
  }
}