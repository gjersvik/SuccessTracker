part of success_tacker_test;

dayTest() => group('Day', (){
  Day day = null;
  
  setUp((){
    day = new Day();
  });
  
  tearDown((){
    day = null;
  });
  
  test('starts empty', (){
    expect(day.day, 0, reason: 'Day.day is not 0');
    expect(day.successes, 0, reason: 'Day.successes is not 0');
    expect(day.focus, isFalse, reason: 'Day.focus is not false');
  });
  
  test('starts consistend', (){
    expect(day.elem.classes.contains('empty'), isTrue);
    expect(day.elem.classes.length, 1);
    expect(day.elem.text, isEmpty);
  });
  
  test('if .focus is true then .elem has class big',(){
    day.day = 1;
    expect(day.elem.classes.contains('big'),isFalse);
    day.focus = true;
    expect(day.elem.classes.contains('big'),isTrue);
  });
  
  test('.elem.text starts wit .day and : .',(){
    day.day = 1;
    expect(day.elem.text,startsWith('1: '));
    day.day = 27;
    expect(day.elem.text,startsWith('27: '));
  });

  test('when .day is not 0 class has day',(){
    day.day = 27;
    expect(day.elem.classes.contains('day'), isTrue);
  });
  
  test('when .day is 0 class has only empty',(){
    day.day = 27;
    day.focus = true;
    day.day = 0;
    expect(day.elem.classes.contains('empty'), isTrue);
    expect(day.elem.classes.length, 1);
  });
  
  test('when .day is 0 class has no text',(){
    day.day = 27;
    day.focus = true;
    day.day = 0;
    expect(day.elem.text, isEmpty);
  });
});