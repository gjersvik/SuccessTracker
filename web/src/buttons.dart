part of success_tacker;

class Buttons{
  Element _elem;
  
  Stream onInc;
  Stream onDec;
  
  Buttons([selector = "#buttons"]){
    _elem = query(selector);
    
    onInc = _elem.query(".inc").onClick;
    onDec = _elem.query(".dec").onClick;
  }
}