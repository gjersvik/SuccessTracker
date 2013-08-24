part of success;

class Drive extends Store{
  
  driveclient.Drive _drive;
  
  Drive(GoogleOAuth2 oauth2){
    _drive = new driveclient.Drive(oauth2);
    _drive.makeAuthRequests = true;
  }
  
  Future<Entity> load(String name){
    return _getMetaData().then((meta){
      if(!meta.containsKey(name)){
        throw new KeyNotFound();
      }
      Token token = _drive.auth.token;
      
      return HttpRequest.request(meta[name].downloadUrl, 
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
            
            return new Entity(name, DateTime.parse(meta[name].modifiedDate), new Uint16List.view(buffer));
          });
    });
  }
  
  Future<Entity> save(Entity entity){
    drive.File file = new drive.File.fromJson({
      'title': entity.name,
      'mimeType': 'application/octet-stream',
      'parents': [{'id': 'appdata'}]
    });
    String base64 = CryptoUtils.bytesToBase64(entity.data.toList());
    
    return _drive.files.insert(file,content:base64).then((drive.File file){
      Entity e = new Entity(file.title,DateTime.parse(file.modifiedDate),entity.data);
      
      return e;
    });
  }
  Stream<Entity> get onChange {
    
  }
  
  Future<Map<String,drive.File>> _getMetaData(){
    return _drive.files.list(q: "'appdata' in parents").then((drive.FileList filelist){
      var meta = {};
      filelist.items.forEach((drive.File file) => meta[file.title] = file);
      return meta;
    });
  }
}