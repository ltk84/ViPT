abstract class SqfliteHelper<T, E> {
  String tableName = '';
  Future<E?> fetch(T id);
  Future<void> add(E obj);
  Future<void> update(T id, E obj);
  Future<void> delete(T id);
  Future<List<E>> fetchAll();
}
