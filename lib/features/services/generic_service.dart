import '../repository/GenericRepository.dart';

class GenericService<TEntity>
{
  final GenericRepository<TEntity,dynamic> repository;

  GenericService(this.repository);

  Future<int> create(TEntity entity) =>
    repository.insert(entity);

  Future<bool> update(TEntity entity) =>
    repository.update(entity);

  Future<TEntity?> getById(int id) =>
    repository.findById(id);

  Future<List<TEntity>> getAll() =>
    repository.getAll();

  Future<void> deleteById(int id) =>
    repository.deleteById(id);
}