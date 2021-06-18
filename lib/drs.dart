//import 'dart:html';
// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pothole_detector/camera.dart';
import 'speedDialButton.dart';

class Drs extends StatefulWidget {
  // Drs({image});

  // String image;

  @override
  _DrsState createState() => _DrsState();
}

class _DrsState extends State<Drs> {
  var _image;

// @override
// void initState() {
//   super.initState();
//   // _image= widget.image;
//   if(_image==null)
//   {
//     print("null");
//   }else
//   print("Not null");

//   //getImage();
// }
  Future getImage() async {
// setState(() {
//   _image = File(path);
// });
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadImage(BuildContext context) async {
    String filename = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(filename);
    //StorageFileDownloadTask downloadTask = firebaseStorageRef.writeToFile(_image);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    setState(() {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Report Registered successfully")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct Report System',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {
                uploadImage(context);
              }),
        ],
      ),
      floatingActionButton: dialer(backgroundColor: Colors.blue, children: [
        new dialChild(
          backgroundColor: Colors.lightBlue,
          text: "Click Photo",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CameraScreen()));
          },
          icon: Icons.camera,
        ),
        dialChild(
            backgroundColor: Colors.lightBlue,
            text: "Choose from gallary",
            icon: Icons.photo_library,
            onPressed: () {
              getImage();
            })
      ]),
      body: Builder(
        builder: (context) => Container(
          child: Center(
            child: (_image != null)
                ? Image.file(
                    _image,
                    fit: BoxFit.fill,
                  )
                : Text("Upload an image"),
          ),
        ),
      ),
    );
  }
}
