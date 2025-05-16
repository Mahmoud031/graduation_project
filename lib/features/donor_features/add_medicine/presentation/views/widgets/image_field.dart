import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key, required this.onFileChanged});
  final ValueChanged<File?> onFileChanged;
  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  bool isLoading = false;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await pickImage();
          } catch (e) {
            // TODO
          }
          isLoading = false;
          setState(() {});
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                width: 335,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFFCCCCCC),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: imageFile != null
                    ? Image.file(imageFile!, fit: BoxFit.cover)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            color: Color(0xFF1EB5B8),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Upload Medicine Image',
                              textAlign: TextAlign.center,
                              style: TextStyles.textstyle14.copyWith(
                                color: Color(0xFF1EB5B8),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Visibility(
              visible: imageFile != null,
              child: Positioned(
                top: -12,
                left: 5,
                child: IconButton(
                    onPressed: () {
                      imageFile = null;
                      widget.onFileChanged(imageFile);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Color(0xFFEF5350),
                      size: 30,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);
    widget.onFileChanged(imageFile!);
  }
}
