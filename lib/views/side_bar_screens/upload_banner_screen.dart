import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app_admin_panel/controllers/banner_controller.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '\banner-screen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Banners",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Divider(color: Colors.grey, thickness: 2),

        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child:
                  _image != null
                      ? Image.memory(_image)
                      : Center(child: Text('Category image')),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _bannerController.UploadBanner(
                    pickedImage: _image,
                    context: context,
                  );
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: Text("Pick image"),
          ),
        ),

        Divider(
          color: Colors.grey,
        ),
        BannerWidget(),
      ],
    );
  }
}
