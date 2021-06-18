import 'dart:typed_data';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  final Uint8List imageBytes;

  ConfirmScreen({this.imageBytes});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: "cameraPicture",
          child: Transform.scale(
            scale: 0.75 / deviceRatio,
            child: Center(
                child: AspectRatio(
              aspectRatio: 0.75,
              child: Image.memory(imageBytes),
            )),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0, right: 35.0),
            child: Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.lightGreen,
                  highlightElevation: 20.0,
                  child: Icon(Icons.check, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, imageBytes);
                  },
                ))),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0, left: 35.0),
          child: Container(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              highlightElevation: 20.0,
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ]),
    );
  }
}
