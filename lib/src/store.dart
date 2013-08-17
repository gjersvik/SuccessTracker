part of success;

class KeyNotFound{}

abstract class Store{
  Future<Entity> load(String key);
  Future<Entity> save(Entity entity);
  Stream<Entity> get onChange;
}