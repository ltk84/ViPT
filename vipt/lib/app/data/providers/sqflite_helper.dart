abstract class SqfliteHelper<T, E> {
  String tableName = '';
  Future<E?> fetch(T id);
  Future<List<E>> fetchByDate(DateTime dateTime);
  Future<E> add(E obj);
  Future<void> update(T id, E obj);
  Future<void> delete(T id);
  Future<List<E>> fetchAll();
}
