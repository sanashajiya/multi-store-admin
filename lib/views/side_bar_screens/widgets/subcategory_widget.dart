import 'package:flutter/material.dart';
import 'package:web_app_admin_panel/controllers/subcategory_controller.dart';
import 'package:web_app_admin_panel/models/subcategory.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Subcategory>> futureCategories;
  @override
  void initState() {
    super.initState();
    // Fetch categories from the API
    futureCategories = SubcategoryController().loadSubCategories();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading Subcategories: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty || !snapshot.hasData) {
          return Text('No Subcategories found');
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(subcategory.image, height: 100, width: 100),
                  ),
                  Text(subcategory.subCategoryName),
                ],
              );
            },
          );
        }
      },
    );
  }
}
