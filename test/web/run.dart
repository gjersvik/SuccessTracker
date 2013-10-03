library success_tacker_test;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';

import '../../web/index.dart';

main(){
  useHtmlEnhancedConfiguration();
  test('test', (){
    fail('test fails');
  });
}