import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'CircleReveal.dart';
import 'ConfirmScreen.dart';
import 'drs.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  CameraController cameraController;
  List<CameraDescription> cameras;

  bool gotCameras = false;
  bool clicked = false;

  String filePath;
  Uint8List result;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    getAvailableCamera();
  }

  Future<void> getAvailableCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);

    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        gotCameras = true;
      });
    });
  }

  void dispose() {
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: gotCameras == false || !cameraController.value.isInitialized
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Hero(
                  tag: "cameraPicture",
                  child: Transform.scale(
                    scale: 0.75 / deviceRatio,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 0.75,
                        child: CameraPreview(
                          cameraController,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: Border.all(width: 4.0, color: Colors.white),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      onTap: clicked
                          ? null
                          : () async {
                              clicked = true;
                              animationController.forward();

                              final Directory appDirectory =
                                  await getApplicationDocumentsDirectory();

                              final String pictureDirectory =
                                  '${appDirectory.path}/Pictures';

                              final Directory dirFinal =
                                  await Directory(pictureDirectory)
                                      .create(recursive: true);

                              final String currentTime = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              filePath = '${dirFinal.path}/$currentTime.jpg';
                              print(filePath);

                              await cameraController.takePicture(filePath);
                              var img = File(filePath);
                              if (img == null) {
                                print("null-------------------");
                              } else
                                print("Not null------------------");

                              // List<int> imgBytes =
                              //     File(filePath).readAsBytesSync();
                              // List<int> compressedImg =
                              //     await FlutterImageCompress.compressWithList(
                              //         imgBytes,
                              //         minHeight: 667,
                              //         minWidth: 500);

                              // var decodedImg = await decodeImageFromList(
                              //     Uint8List.fromList(imgBytes));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Drs()));

                              // if (decodedImg.height < decodedImg.width) {
                              //   showDialog(
                              //       barrierDismissible: false,
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10.0))),
                              //           elevation: 10.0,
                              //           contentPadding: EdgeInsets.all(0.0),
                              //           content: Text(
                              //             "Rotate Your Phone",
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.w400,
                              //                 fontSize: 18.0),
                              //             textAlign: TextAlign.center,
                              //           ),
                              //           title: Image(
                              //             image: AssetImage(
                              //                 'assets/icons/rotate.gif'),
                              //             width: 100.0,
                              //             height: 100.0,
                              //             color: Colors.black,
                              //           ),
                              //           actions: <Widget>[
                              //             FlatButton(
                              //               child: Text("OK"),
                              //               onPressed: () {
                              //                 animationController.reverse();
                              //                 clicked = false;
                              //                 Navigator.of(context).pop();
                              //               },
                              //             )
                              //           ],
                              //         );
                              //       });
                              // } else
                              //{

                              // result = await Navigator.push(context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) {
                              //   return ConfirmScreen(
                              //     imageBytes:
                              //         Uint8List.fromList(compressedImg),
                              //   );
                              // }));

                              // if (result != null) {
                              //   Navigator.pop(context, result);
                              // } else {
                              //   clicked = false;
                              // //   animationController.reverse();
                              // }
                            }
                      // }
                      ),
                ),
                CircleReveal(
                  revealPercent: animation.value,
                  offset: Offset(size.width / 2, size.height * 0.9),
                  child: Container(
                    color: Colors.white,
                  ),
                )
              ],
            ),
    );
  }
}
