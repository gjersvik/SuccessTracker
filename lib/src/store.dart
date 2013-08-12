part of success;

abstract class Store{
  Future<Uint16List> load(String key);
  Future<Uint16List> save(String key, Uint16List data);
  Stream<String> get onChange;
}