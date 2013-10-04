library success_tacker;

import 'dart:async';
import 'dart:html';


import "package:google_oauth2_client/google_oauth2_browser.dart";
import "package:intl/intl.dart";

import "package:success_tracker/success.dart";

import '../config.dart';

part 'src/buttons.dart';
part 'src/calendar.dart';
part 'src/controller.dart';
part 'src/datepicker.dart';
part 'src/day.dart';
part 'src/login.dart';
part 'src/model.dart';
part 'src/week.dart';

main(){
  var controll = new Controller(const Config());
  controll.start();
}