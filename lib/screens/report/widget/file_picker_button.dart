import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:path/path.dart' as p;
import 'package:recything_mobile/widgets/error_snackbar.dart';

class FilePickerButton extends StatefulWidget {
  final List<File>? Function(List<File>?) onImagesSelected;

  const FilePickerButton({Key? key, required this.onImagesSelected})
      : super(key: key);

  @override
  _FilePickerButtonState createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  FilePickerResult? selectedFiles;
  List<File> value = [];

  List<Widget> widgets = [];

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );

    if (result != null) {
      int totalSizeInBytes = 0;

      for (var file in result.files) {
        totalSizeInBytes += file.size;
      }

      double totalSizeInMB = totalSizeInBytes / (1024 * 1024);

      if (totalSizeInMB > 20) {
        // print('Total file size exceeds 20 MB');
        ErrorSnackbar.showSnackbar(
          context,
          message: "Ukuran total file terlalu besar",
          title: "Error",
        );
        return;
      }
    }

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      value.addAll(files);
      widget.onImagesSelected(value);

      updateWidgets();
    } else {
      // User canceled the picker
    }
    setState(() {});
  }

  void removeFile(int index) {
    setState(() {
      if (index >= 0 && index < value.length) {
        value.removeAt(index);
        updateWidgets();
        widget.onImagesSelected(value);
      }
    });
  }

  void updateWidgets() {
    widgets = value.asMap().entries.map((entry) {
      final int index = entry.key;
      final File file = entry.value;

      Widget widget;

      if (isImageFile(file)) {
        widget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.file(
                  File(file.path),
                  width: 80,
                  height: 80,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    removeFile(index);
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
        );
      } else if (isVideoFile(file)) {
        // Assuming you have a function isVideoFile to check if it's a video file
        widget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    removeFile(index);
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
        );
      } else {
        widget = Container();
      }

      return widget;
    }).toList();
  }

  bool isImageFile(File file) {
    String extension = p.extension(file.path).toLowerCase();
    return imageExtensions.contains(extension);
  }

  bool isVideoFile(File file) {
    String extension = p.extension(file.path).toLowerCase();
    return videoExtensions.contains(extension);
  }

// Define lists of common image and video file extensions
  List<String> imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
  List<String> videoExtensions = ['.mp4', '.avi', '.mkv', '.mov', '.wmv'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...widgets,
          GestureDetector(
            onTap: pickFiles,
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
                color: Pallete.dark4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
