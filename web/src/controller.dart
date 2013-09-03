part of success_tacker;

class Controller{
  bool online = false;
  DateTime date;
  
  Config _conf;
  GoogleOAuth2 _auth;
  var _buttons = new Buttons();
  var _cal = new Calendar();
  var _date = new DatePicker();
  Drive _drive;
  var _login = new Login();
  var _model = new Model();
  
  Controller(this._conf);
  
  start(){
    const scope = const ['https://www.googleapis.com/auth/drive.appdata'];
    _auth = new GoogleOAuth2(_conf.googleClientID,scope, tokenLoaded:goOnline, autoLogin: true);
    
    _date.onDateChange.listen(dateChange);
    _cal.onDateChange.listen(dateChange);
    _login.onActivate.listen((_)=>_auth.login());
    _buttons.onInc.listen(inc);
    _buttons.onDec.listen(dec);
    
    _model.onNewData.listen(dataChange);
    
    dateChange(new DateTime.now());
  }
  
  dateChange(DateTime date){
    this.date = date;
    _cal.updateDate(date);
    _date.update(date);
  }
  
  dataChange([_]){
    _cal.updateData(_model.getDay);
  }
  
  goOnline([_]){
    online = true;
    _login.hide();  
    _drive = new Drive(_auth);
    _model.addStore(_drive);
  }
  
  inc([_]){
    _model.inc(date);
  }
  
  dec([_]){
    _model.dec(date);
  }
}