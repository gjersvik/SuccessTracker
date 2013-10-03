part of success_tacker;

class Day{
  final Element elem = new Element.div();
  
  int _day = 0;
  int successes;
  
  int get day => _day;
  set day(int d){
    if(d == _day){
      return;
    }
    _day = d;
    elem.classes.toggle('day', d != 0);
    _setText(_day,'');
  }
  
  bool get focus => elem.classes.contains('big');
  set focus(bool f) => elem.classes.toggle('big', f);
  
  _setText(day,succsess) => elem.text = '$day: succsess';
}