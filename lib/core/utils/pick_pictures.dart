import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickCameraImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

Future<File?> pickGalleryImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

// Future<List<File>> pickImages(BuildContext context) async {
//   List<File> images = [];
//   final ImagePicker picker = ImagePicker();
//   final imageFiles = await picker.pickMultiImage(imageQuality: 30);
//   if (imageFiles.isNotEmpty) {
//     // if (imageFiles.length > 6) {
//     //   if (context.mounted) {
//     //     showSnackbar(context, 'Maximum image limit is 6');
//     //   }
//     //   imageFiles.removeRange(6, imageFiles.length);
//     // }
//     for (final image in imageFiles) {
//       images.add(File(image.path));
//     }
//   }
//   return images;
// }


