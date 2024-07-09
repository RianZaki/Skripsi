// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:recything_mobile/constants/pallete.dart';

class ImagePickerButton extends StatefulWidget {
  final void Function(List<XFile>?) onImagesSelected;

  const ImagePickerButton({Key? key, required this.onImagesSelected})
      : super(key: key);

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  List<XFile>? selectedImages = [];

  Future<void> pickImage() async {
    var maxFileSizeInBytes = 2 * 1048576;
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    if (pickedImages != null) {
      List<XFile> validImages = [];

      for (var pickedImage in pickedImages) {
        var imagePath = await pickedImage.readAsBytes();
        var fileSize = imagePath.length;

        if (fileSize <= maxFileSizeInBytes) {
          validImages.add(pickedImage);
        } else {
          SnackBar(content: Text('ukuran gambar melebihi 2MB')); //snackbar nggak muncul
          print('File is too large: ${pickedImage.path}');
        }
      }

      setState(() {
        selectedImages!.addAll(validImages);
      });

      widget.onImagesSelected(selectedImages);
    }
    // if (pickedImages != null) {
    //   setState(() {
    //     selectedImages!.addAll(pickedImages);
    //   });
    //   widget.onImagesSelected(selectedImages);
    // }
  }

  void removeImage(int index) {
    setState(() {
      selectedImages!.removeAt(index);
      widget.onImagesSelected(selectedImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (selectedImages != null && selectedImages!.isNotEmpty)
          for (int index = 0; index < selectedImages!.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Image.file(
                    File(selectedImages![index].path),
                    width: 80,
                    height: 80,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        removeImage(index);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.main,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        GestureDetector(
          onTap: pickImage,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Pallete.dark4,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
