import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";

Future<String> uploadImageAndGetUrl(PlatformFile file) async {
  final fileName = "${DateTime.now().millisecondsSinceEpoch}_${file.name}";
  final ref = FirebaseStorage.instance.ref().child(fileName);
  final metadata = SettableMetadata(
    contentType: 'image/${file.extension ?? 'jpeg'}',
  );

  await ref.putData(file.bytes!, metadata);

  final url = await ref.getDownloadURL();
  return url;
}
