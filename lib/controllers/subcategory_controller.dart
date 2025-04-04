import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_app_admin_panel/global_variable.dart';
import 'package:web_app_admin_panel/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:web_app_admin_panel/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('da4dh3xnx', 'gyy11nms');

      // upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'categoryImages',
        ),
      );
      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/subCategories"),
        body: subcategory.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackbar(context, "SubCategory uploaded successfully");
        },
      );
    } catch (e) {
      print("$e");
    }
  }

   Future<List<Subcategory>> loadSubCategories() async {
    try {
      // send an http get request to load the category
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Subcategory> subcategories =
            data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();

        return subcategories;
      } else {
        throw Exception('failed to load sub categories');
      }
    } catch (e) {
      throw Exception('Error loading sub bcategories');
    }
  }
}
