part of success;

class Drive extends Store{
  
  driveclient.Drive _drive;
  DriveMeta _meta;
  
  Drive(GoogleOAuth2 oauth2){
    _drive = new driveclient.Drive(oauth2);
    _drive.makeAuthRequests = true;
    
    _meta = new DriveMeta(_drive);
  }
  
  Future<Entity> load(String name){
    return _meta.getMeta(name).then((drive.File file){

      Token token = _drive.auth.token;
      
      return HttpRequest.request(file.downloadUrl, 
          withCredentials: false , 
          responseType: 'arraybuffer', 
          requestHeaders: {'Authorization': '${token.type} ${token.data}'} ).then((HttpRequest req){
            ByteBuffer buffer;
            if(req.response is ByteBuffer){
              buffer = req.response;
            }else if(req.response is TypedData){
              buffer = (req.response as TypedData).buffer;
            }else{
              throw "Got an unexpected type: ${req.response.runtimeType}";
            }            
            print(file.modifiedDate);
            return new Entity(name, DateTime.parse(file.modifiedDate), new Uint16List.view(buffer));
          });
    });
  }
  
  Future<Entity> save(Entity entity){
    return _meta.getMeta(entity.name)
        .then((drive.File file) => _update(file,entity.data))
        .catchError((_) => _insert(entity.name,entity.data), test: (e) => e is KeyNotFound);
  }
  
  Stream<String> get onChange => _meta.onChange;
  
  Future<Entity> _update(drive.File file, data){
    String base64 = CryptoUtils.bytesToBase64(new Uint8List.view(data.buffer).toList());
    
    return _drive.files.update(file, file.id, content:base64).then((drive.File file){
      Entity e = new Entity(file.title,DateTime.parse(file.modifiedDate),data);
      
      return e;
    });
  }
  
  _insert(name,data){
    drive.File file = new drive.File.fromJson({
      'title': name,
      'mimeType': 'application/octet-stream',
      'parents': [{'id': 'appdata'}]
    });
    String base64 = CryptoUtils.bytesToBase64(new Uint8List.view(data.buffer).toList());
    
    return _drive.files.insert(file,content:base64).then((drive.File file){
      Entity e = new Entity(file.title,DateTime.parse(file.modifiedDate),data);
      
      return e;
    });
  }
}