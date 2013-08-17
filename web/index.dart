import 'dart:async';

import "package:google_oauth2_client/google_oauth2_browser.dart";

import '../config.dart';

const Config config = const Config();

main(){
  const scope = const ['https://www.googleapis.com/auth/drive.appdata'];
  final auth = new GoogleOAuth2(config.googleClientID,scope);
  print('Try to log inn');
  auth.login(immediate:true).then((_){
    print('Success');
  });
}