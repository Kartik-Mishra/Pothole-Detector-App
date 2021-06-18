import 'package:flutter/material.dart';
import 'drs.dart';
import 'ride.dart';
import 'camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans"
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        
        backgroundColor: Colors.transparent,
        title: Text("Select reporting system",),
        centerTitle: true,

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom:15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: InkWell(
                  child: new Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 200, 200, 200)),
                    child: Center(
                        child: new Image.asset("assets/drs.png", width: 70)),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Drs()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0, bottom: 20 ),
                child: new Text("Direct Report System", style: TextStyle(fontSize: 16 , fontFamily: "OpenSans",  ), ),
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                height: 20,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: InkWell(
                  child: new Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 200, 200, 200)),
                    child: Center(
                        child: new Image.asset("assets/ride.png", width: 70)),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Ride()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0, bottom: 10 ),
                child: new Text("Ride Mode", style: TextStyle(fontSize: 16 , fontFamily: "OpenSans",  ), ),
              ),

              // FloatingActionButton(
              //   child: Image.asset(
              //     "assets/ride.png",
              //     width: 20,
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => Drs()));
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.looks_two),
              //   onPressed: () {},
              // )


            ],
          ),
        ),
      ),
    );
  }
}
