import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// A file chosen by the user, read into memory.
class PickedDocument {
  const PickedDocument({required this.name, required this.bytes});
  final String name;
  final Uint8List bytes;
}

/// Camera on phones, file picker on web and desktop.
class FilePickService {
  final _imagePicker = ImagePicker();

  bool get canUseCamera =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<PickedDocument?> takePhoto() async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 2400,
    );
    if (photo == null) return null;
    return PickedDocument(name: photo.name, bytes: await photo.readAsBytes());
  }

  /// A spreadsheet saved as CSV, e.g. hospitals to import.
  Future<PickedDocument?> pickCsv() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['csv'],
    );
    final file = files.firstOrNull;
    if (file == null) return null;
    return PickedDocument(
      name: file.name,
      bytes: await file.xFile.readAsBytes(),
    );
  }

  Future<PickedDocument?> pickFile() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png', 'webp', 'heic'],
    );
    final file = files.firstOrNull;
    if (file == null) return null;
    return PickedDocument(
      name: file.name,
      bytes: await file.xFile.readAsBytes(),
    );
  }
}
