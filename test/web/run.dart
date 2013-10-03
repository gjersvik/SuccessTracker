library success_tacker_test;

import 'dart:html';

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';

import '../../web/index.dart';

part 'src/day.dart';

main(){
  useHtmlEnhancedConfiguration();
  
  dayTest();
}