part of success;

class Drive extends Store{
  
  driveclient.Drive _drive;
  
  Drive(GoogleOAuth2 oauth2){
    _drive = new driveclient.Drive(oauth2);
    _drive.makeAuthRequests = true;
    //_drive.files.list(q: "'appdata' in parents");
  }
  
  Future<Entity> load(String name){
    
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
}