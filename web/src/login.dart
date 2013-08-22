part of success_tacker;

class Login{
  Element _elem;
  
  Stream onActivate;
  
  Login([selector = "#login"]){
    _elem = query(selector);
    onActivate = _elem.onClick;
  }
  
  show() => _elem.hidden = false;
  hide() => _elem.hidden = true;
}