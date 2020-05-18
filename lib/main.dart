import 'package:dice_game/states.dart';
import 'package:dice_game/swatch.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StateManagement())],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateManagement();
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        brightness: Brightness.dark,
        title: Center(
          child: Text(
            'Dice, Dice!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        //backgroundColor: Color.fromRGBO(11, 19, 43, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MdiIcons.dice1Outline,
              size: 300,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
