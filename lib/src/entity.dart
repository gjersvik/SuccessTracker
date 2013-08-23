part of success;

class Entity{
  final String name;
  final DateTime timestamp;
  final Uint16List data;
  
  
  const Entity(this.name,this.timestamp,this.data);
  factory Entity.create(name,length){
    return new Entity(name,new DateTime.now(),new Uint16List(length));
  }
  factory Entity.copy(Entity from){
    return new Entity(from.name,from.timestamp,new Uint16List.fromList(from.data));
  }
}