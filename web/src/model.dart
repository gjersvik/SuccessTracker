part of success_tacker;

class Model{
  Stream onNewData;
  
  Store _store;
  Entity _entery;
  StreamSink _sink;
  Model(){
    var sink = new StreamController.broadcast();
    _sink = sink.sink;
    onNewData = sink.stream;
  }
  
  addStore(Store store){
    _store = store;
    _store.onChange.listen((_) => _sink.add(null));
    _store.load(new DateTime.now().year.toString())
      .then((e){
        _entery = e;
      })
      .catchError((_){
        _entery = _newEntity(new DateTime.now().year);
      }, test: (e) => e is KeyNotFound)
      .whenComplete(()=>_sink.add(null));
  }
  
  int getDay(DateTime date){
    if(_entery == null){
      return 0;
    }
    return _entery.data[getIndex(date)];
  }
  
  inc(DateTime date){
    if(_entery == null){
      return;
    }
    _entery.data[getIndex(date)] += 1;
    _store.save(_entery)
      .then((e){
        _entery = e;
        _sink.add(null);
      });
  }
  
  dec(DateTime date){
    if(_entery == null){
      return;
    }
    _entery.data[getIndex(date)] -= 1;
    _store.save(_entery)
      .then((e){
        _entery = e;
        _sink.add(null);
      });
  }
  
  int getIndex(DateTime date) => date.difference(new DateTime(date.year)).inDays;
  
  Entity _newEntity(int year){
    var length = 365;
    if(year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)){
      length = 366;
    }
    
    return new Entity.create(year.toString(), length);
  }
}