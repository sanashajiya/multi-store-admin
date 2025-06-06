import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_app_admin_panel/global_variable.dart';
import 'package:web_app_admin_panel/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:web_app_admin_panel/services/manage_http_response.dart';

class BannerController {
  UploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic('da4dh3xnx', 'gyy11nms');
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'banners',
        ),
      );
      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: "", image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackbar(context, "Banner Uploaded Successfully");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        // throw an exception if the server responded with an error status code
        throw Exception("Failed to load banners");
      }
    } catch (e) {
      throw Exception("Error loading Banners");
    }
  }
}
