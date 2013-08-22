library success_tacker;

import 'dart:async';
import 'dart:html';


import "package:google_oauth2_client/google_oauth2_browser.dart";

import '../config.dart';

part 'src/login.dart';

const Config config = const Config();

main(){
  var login = new Login();
  
  online(_){
    login.hide();
  }
  
  const scope = const ['https://www.googleapis.com/auth/drive.appdata'];
  final auth = new GoogleOAuth2(config.googleClientID,scope, tokenLoaded:online, autoLogin: true);
  login.onActivate.listen((_)=>auth.login());
}