part of success;

class DriveMeta{
  Duration minAge = new Duration(seconds: 10);
  Duration syncInerval = new Duration(minutes: 1);
  
  DateTime lastFile = new DateTime.utc(1900);
  DateTime lastSync = new DateTime.utc(1900);
  
  driveclient.Drive _drive;
  bool _syncing = false;
  Map<String,drive.File> _meta = {};
  var _stream = new StreamController.broadcast();
  
  List<Completer> _backlog = [];
  
  DriveMeta(this._drive){
    new Timer(syncInerval, _resync);
  }
  
  Stream<String> get onChange => _stream.stream;
  
  Future<drive.File> getMeta(name){
    return sync().then((_){
      if(_meta.containsKey(name)){
        return _meta[name];
      }
      throw new KeyNotFound();
    });
  }
  
  sync({force:false}){
    if(force == false && _isFresh()){
      return new Future.value(null);
    }
    if(_syncing){
      var comp = new Completer();
      _backlog.add(comp);
      return comp.future;
    }
    _syncing = true;
    
    return _drive.files.list(q: "'appdata' in parents").then((drive.FileList filelist){
      filelist.items.forEach((drive.File file){
        var templast = lastFile;
        var filetime = DateTime.parse(file.modifiedDate);
        if(filetime.isAfter(templast)){
          _meta[file.title] = file;
          _stream.add(file.title);
          if(filetime.isAfter(lastFile)){
            lastFile = filetime;
          }
        }
      });
      
      lastSync = new DateTime.now().toUtc();
      _syncing = false;
      _backlog.forEach((c)=> c.complete(null));
      _backlog.clear();
      
      return null;
    });
  }
  
  bool _isFresh() => lastSync.add(minAge).isAfter(new DateTime.now());
  
  _resync([_]){
    sync().then((_)=> new Timer(syncInerval, _resync));
  }
}