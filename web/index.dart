library success_tacker;

import 'dart:async';
import 'dart:html';


import "package:google_oauth2_client/google_oauth2_browser.dart";
import "package:intl/intl.dart";

import "package:success_tracker/success.dart";

import '../config.dart';

part 'src/login.dart';
part 'src/datepicker.dart';
part 'src/calendar.dart';

const Config config = const Config();

main(){
  var login = new Login();
  var date = new DatePicker();
  var cal = new Calendar();
  
  date.onDateChange.listen(cal.updateDate);
  cal.onDateChange.listen(date.update);
  date.update(new DateTime.now());
  var auth;
  
  online(_){
    login.hide();
    
    print(auth.token);
    Drive drive = new Drive(auth);
    drive.save(new Entity.create('test', 365)).then((Entity e){
      print(e.name);
      print(e.timestamp);
      print(e.data.lengthInBytes);
    }).then((_){
      drive.load('test').then((Entity e){
        print(e.name);
        print(e.timestamp);
        print(e.data.lengthInBytes);
      });
    });
    
  }
  
  const scope = const ['https://www.googleapis.com/auth/drive.appdata'];
  auth = new GoogleOAuth2(config.googleClientID,scope, tokenLoaded:online, autoLogin: true);
  login.onActivate.listen((_)=>auth.login());
}