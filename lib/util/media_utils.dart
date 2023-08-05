import 'dart:io';

import 'package:image_picker/image_picker.dart' as ip;

enum MediaSource { camera, gallery }

class MediaUtils {
  static Future<File?> pickMedia(MediaSource imageSource) async {
    try {
      String? path;

      switch (imageSource) {
        case MediaSource.camera:
          path =
              (await ip.ImagePicker().pickImage(source: ip.ImageSource.camera))
                  ?.path;
          break;
        case MediaSource.gallery:
          path =
              (await ip.ImagePicker().pickImage(source: ip.ImageSource.gallery))
                  ?.path;
          break;
      }

      if (path != null) {
        return File(path);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
