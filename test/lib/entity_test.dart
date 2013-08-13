library succsess_entity_test;

import 'package:unittest/unittest.dart';
import 'package:success_tracker/success.dart';

main(){
  group('Entity:',(){
    test('Entity.copy data is not a refrense',(){
      var base = new Entity('Name', new DateTime.now(), new Uint16List(10));
      var copy = new Entity.copy(base);
      copy.data[0] = 100;
      expect(base.data[0],0);
    });
  });
}

