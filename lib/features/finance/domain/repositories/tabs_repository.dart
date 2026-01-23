abstract class TabsRepository<T> {
  Future<List<T>> getAll();
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(int indexRow);
  Future<int> getNextIndex();
}