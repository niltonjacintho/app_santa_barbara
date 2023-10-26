import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class ImageserviceService  {
  @override
  void dispose() {}

  File _imageFile;
  String _uploadedFileURL = ''; //new Uri();

  File get imageName {
    print('IMAGE FILE ');
    print(_imageFile == null);
    if (_imageFile == null) {
      print('VOLTOU NULL');
      return null;
    } else {
      return _imageFile; //.uri.toString();
    }
    // return '';
  }

  String get url {
    return _uploadedFileURL;
  }

  Future<File> chooseFile() async {
    final picker = ImagePicker();
    final pickedFile = picker.getImage(source: ImageSource.gallery);
    File file = pickedFile as File;
    _imageFile = file;
    return file;
  }

  Future uploadFile(String grupo) async {
    print('IMAGE FILE $_imageFile');
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('$grupo/${Path.basename(_imageFile.path)}}');
    UploadTask uploadTask = storageReference.putFile(_imageFile);
    TaskSnapshot snapshot = uploadTask.snapshot; // .onComplete;
    await storageReference.getDownloadURL().then((fileURL) async {
      await snapshot.ref.getDownloadURL().then((onValue) async {
        _uploadedFileURL = onValue;
        return onValue;
      });
    });
  }
}
