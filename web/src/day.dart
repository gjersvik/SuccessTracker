part of success_tacker;

class Day{
  final Element elem = new Element.div();
  
  int _day = 0;
  bool _focus = false;
  String _successes = '';
  
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
  
  int get successes => _successes.length;
  set successes(int s){
    if(_successes.length == s){
      return;
    }
    _successes = new List.filled(s, 'X').join('');
    _setText();
  }
  
  
  _setClass(){
    elem.classes.toggle('day', _day != 0);
    elem.classes.toggle('empty', _day == 0);
    elem.classes.toggle('big', _focus);
  }
  
  _setText(){
    if(_day != 0){
      elem.text = '$_day: $_successes';
    }else{
      elem.text = '';
    }
  }
}