import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final StorageReference _storeRef = FirebaseStorage.instance.ref();

  StorageReference get storeRef => this._storeRef;

  upload({String path, File file, Function onSuccess(String s), Function onFailure(String e)}) async {
    StorageUploadTask task = this.storeRef.child(path).putFile(file, StorageMetadata(contentType: 'image/png'));
    StorageTaskSnapshot snapshot = await task.onComplete;
    dynamic downloadURL = await snapshot.ref.getDownloadURL();
    String url = downloadURL.toString();

    if (task.isSuccessful) {
      onSuccess(url);
    } else {
      onFailure('Error Uploading Image...');
      return;
    }
  }

}