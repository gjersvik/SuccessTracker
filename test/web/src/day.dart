part of success_tacker_test;

dayTest() => group('Day', (){
  test('if .focus is true then .elem has class big',(){
    var day = new Day();
    expect(day.elem.classes.contains('big'),isFalse);
    day.focus = true;
    expect(day.elem.classes.contains('big'),isTrue);
  });
  
  test('.elem.text starts wit .day and : .',(){
    var day = new Day();
    day.day = 1;
    expect(day.elem.text,startsWith('1: '));
    day.day = 27;
    expect(day.elem.text,startsWith('27: '));
  });

  test('when .day is not 0 class has day',(){
    var day = new Day();
    day.day = 27;
    expect(day.elem.classes.contains('day'), isTrue);
  });
});