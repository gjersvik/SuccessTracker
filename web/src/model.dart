part of success_tacker;

class Model{
  Stream onNewData;
  
  Store _store;
  Entity _entery;
  StreamSink _sink;
  
  bool _wantToSave = false;
  bool _saving = false;
  
  Model(){
    var sink = new StreamController.broadcast();
    _sink = sink.sink;
    onNewData = sink.stream;
    
    _entery = _newEntity(new DateTime.now().year);
  }
  
  setStore(Store store){
    _store = store;
    _store.onChange.listen(_load);
    _load(new DateTime.now().year.toString());
  }
  
  int getDay(DateTime date) => _entery.data[getIndex(date)];
  
  inc(DateTime date){
    _entery.data[getIndex(date)] += 1;
    _changed();
  }
  
  dec(DateTime date){
    var i = getIndex(date);
    var s = _entery.data[i] - 1;
    if(s == -1){
      return;
    }
    _entery.data[i] = s;
    _changed();
  }
  
  int getIndex(DateTime date) => date.difference(new DateTime(date.year)).inDays;
  
  Entity _newEntity(int year){
    var length = 365;
    if(year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)){
      length = 366;
    }
    
    return new Entity.create(year.toString(), length);
  }
  
  _load(String year){
    _store.load(new DateTime.now().year.toString())
      .then((e){
        _entery = e;
        _sink.add(null);
      })
      .catchError((_){}, test: (e) => e is KeyNotFound);
  }
  
  _changed(){
    _sink.add(null);
    _wantToSave = true;
    if(_saving == false){
      _saving = true;
      new Timer(new Duration(seconds:1),_save);
    }
  }
  
  _save(){
    _wantToSave = false;
    _store.save(_entery)
      .then((e){
        _entery = e;
        if(_wantToSave){
          new Timer(new Duration(seconds:1),_save);
        }else{
          _saving = false;
        }
      });
  }
}