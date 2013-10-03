part of success_tacker;

class Day{
  final Element elem = new Element.div();
  
  int _day = 0;
  bool _focus = false;
  int successes = 0;
  
  Day(){
    _setClass();
    _setText();
  }
  
  int get day => _day;
  set day(int d){
    if(d == _day){
      return;
    }
    _day = d;
    if(d == 0){
      _focus = false;
    }
    
    _setClass();
    _setText();
  }
  
  bool get focus => _focus;
  set focus(bool f){
    if(_focus == f || _day == 0){
      return;
    }
    _focus = f;
    _setClass();
  }
  
  _setClass(){
    elem.classes.toggle('day', _day != 0);
    elem.classes.toggle('empty', _day == 0);
    elem.classes.toggle('big', _focus);
  }
  
  _setText(){
    if(_day != 0){
      elem.text = '$_day: ';
    }else{
      elem.text = '';
    }
  }
}