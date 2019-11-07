import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';


class TimeHelperService {TimeHelperService() {
  setup();
}void setup() async {
  var byteData = await rootBundle.load('packages/timezone/data/2019b.tzf');
  initializeDatabase(byteData.buffer.asUint8List());
}}