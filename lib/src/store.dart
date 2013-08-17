part of success;

abstract class Store{
  Future<Entity> load(String name);
  Future<Entity> save(Entity entity);
  Stream<Entity> get onChange;
}