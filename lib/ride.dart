import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';

class Ride extends StatefulWidget {
  @override
  _RideState createState() => _RideState();
}

class _RideState extends State<Ride> {
  bool turn = false;
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    //Accelerometer events
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    //UserAccelerometer events
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    //UserAccelerometer events
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    for (StreamSubscription<dynamic> sub in _streamSubscriptions) {
      sub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(4))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
        appBar: AppBar(title: Text('Ride Mode')),
        body: Center(
          child: (turn)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      InkWell(
                        child: new Container(
                          height: 50,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Center(
                              child: new Image.asset("assets/power.png",
                                  height: 35, width: 70)),
                        ),
                        onTap: () {
                          setState(() {
                            turn = false;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Accelerometer: $accelerometer'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('UserAccelerometer: $userAccelerometer'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Gyroscope: $gyroscope'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(((_userAccelerometerValues[0] < -1 ||
                                    _userAccelerometerValues[0] > 1 ||
                                    _userAccelerometerValues[1] < -1 ||
                                    _userAccelerometerValues[1] > 1 ||
                                    _userAccelerometerValues[2] < -1 ||
                                    _userAccelerometerValues[2] > 1) &&
                                (_gyroscopeValues[0] > -1 &&
                                    _gyroscopeValues[0] < 1 &&
                                    _gyroscopeValues[1] < -1 &&
                                    _gyroscopeValues[1] < 1 &&
                                    _gyroscopeValues[2] > -1 &&
                                    _gyroscopeValues[2] < 1))
                            ? "Pothole"
                            : " ."),
                      ),
                    ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: new Container(
                        height: 100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                            child:
                                new Image.asset("assets/power.png", width: 70)),
                      ),
                      onTap: () {
                        setState(() {
                          turn = true;
                        });
                      },
                    ),
                  ],
                ),
        ));
  }
}
