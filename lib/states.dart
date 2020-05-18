import 'package:flutter/foundation.dart';
import 'package:shake/shake.dart';
import 'package:flutter/material.dart';

class StateManagement with ChangeNotifier {
  ShakeDetector detector = ShakeDetector.autoStart(
    onPhoneShake: () {
      print("dziala");
    },
  );
  notifyListeners();
}
