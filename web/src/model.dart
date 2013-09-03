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
      });
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
  
  int getIndex(DateTime date) => new DateTime(date.year).difference(date).inDays;
}