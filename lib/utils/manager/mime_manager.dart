
import 'package:accounts/utils/enum/mime_type.dart';
import 'package:mime/mime.dart';

class MimeManager {
  static Map<MimeType, String> mimeTypeToNames = {
    MimeType.svg: 'image/svg+xml',
    MimeType.png: 'image/png',
    MimeType.jpeg: 'image/jpeg',
    MimeType.gif: 'image/gif',
    MimeType.pdf: 'application/pdf',
  };

  static Map<String, MimeType> namesToMimeType = {
    'image/svg+xml': MimeType.svg,
    'image/png': MimeType.png,
    'image/jpeg': MimeType.jpeg,
    'image/gif': MimeType.gif,
    'application/pdf': MimeType.pdf,
  };

  static Map<String, String> namesToExtension = {
    'image/svg+xml': 'svg',
    'image/png': 'png',
    'image/jpeg': 'jpeg',
    'image/gif': 'gif',
    'application/pdf': 'pdf',
  };

  static bool isAvailable(List<String>? fileTypes, String path) {
    final mimeType = lookupMimeType(path);
    return fileTypes?.contains(mimeType) ?? false;
  }

  static MimeType? getType(String? path) {
    if (path != null) {
      final mimeType = lookupMimeType(path);
      return namesToMimeType[mimeType];
    }
    return null;
  }

  static String? getName(MimeType type) {
    return mimeTypeToNames[type];
  }
}
