part of success_tacker_test;

dayTest() => group('Day', (){
  test('if .focus is true then .elem has class big',(){
    var day = new Day();
    expect(day.elem.classes.contains('big'),isFalse);
    day.focus = true;
    expect(day.elem.classes.contains('big'),isTrue);
    day.focus = true;
    expect(day.elem.classes.contains('big'),isTrue);
  });
});