import 'package:flutter/material.dart';
import 'package:web_app_admin_panel/controllers/banner_controller.dart';
import 'package:web_app_admin_panel/models/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futureBanners;
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.data!.isEmpty}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No banners found"));
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(banner.image, height: 100, width: 100),
              );
            },
          );
        }
      },
    );
  }
}
