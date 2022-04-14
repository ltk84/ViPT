abstract class SqfliteHelper<T, E> {
  String tableName = '';
  Future<E?> fetch(T id);
  Future<E?> fetchByDate(DateTime dateTime);
  Future<void> add(E obj) async {}
  Future<void> update(T id, E obj);
  Future<void> delete(T id);
  Future<List<E>> fetchAll();
}
