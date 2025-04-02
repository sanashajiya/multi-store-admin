import 'package:flutter/material.dart';
import 'package:web_app_admin_panel/controllers/category_controller.dart';
import 'package:web_app_admin_panel/models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    super.initState();
    // Fetch categories from the API
    futureCategories = CategoryController().loadCategories();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading categories: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty || !snapshot.hasData) {
          return Text('No categories found');
        } else {
          final categories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(category.image, height: 100, width: 100),
                  ),
                  Text(category.name),
                ],
              );
            },
          );
        }
      },
    );
  }
}
