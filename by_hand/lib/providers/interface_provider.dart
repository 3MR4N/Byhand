class SuperProvider<T> {
  Future<List<T>> getAll() {}
  Future<T> getById(int id) {}
  Future<T> create(T object) {}
  Future<T> update(T object) {}
  bool destory(int id) {}
}