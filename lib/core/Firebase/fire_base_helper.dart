import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper{
   static Future<String> uploadImage(
      { required File file}) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    final image = file.path.split('.').last;

    final ref = storage.ref().child(
        'profile_picture/${DateTime.now().microsecondsSinceEpoch}.$image');

    await ref.putFile(file, SettableMetadata(contentType: 'image/$file'));

    final String imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }
}