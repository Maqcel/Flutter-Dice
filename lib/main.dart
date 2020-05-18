import 'package:dice_game/states.dart';
import 'package:dice_game/swatch.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Dice!',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: MaterialColor(0xFF138A36, materialColor),
        canvasColor: Color.fromRGBO(24, 255, 109, 1),
        accentColor: Color.fromRGBO(52, 64, 58, 1),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20),
          bodyText2: TextStyle(color: Colors.black87),
        ),
      ),
      home: MyHomePage(title: 'Dice Dice!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool shake = false;
  int counter = 0;
  List<double> _userAccelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    //* Screen shake map
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    if (userAccelerometer != null) {
      double z = double.parse(userAccelerometer[2]);
      if (z < -8 || z > 8) {
        print(
            'x: ${userAccelerometer[0]},y: ${userAccelerometer[1]},z: ${userAccelerometer[2]}');
        shake = true;
        counter = 0;
      }
    }
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          shake
              ? Icon(
                  MdiIcons.dice1Outline,
                  size: 400,
                )
              : Container(),
          Text('$counter'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            if (counter == 300) shake = false;
            if (counter < 300) counter++;
            _userAccelerometerValues = <double>[
              event.x,
              event.y,
              event.z,
            ]; //! format x / y / z
          });
        },
      ),
    );
  }
}
