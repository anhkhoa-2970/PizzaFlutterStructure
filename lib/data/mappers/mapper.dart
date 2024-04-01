abstract class Mapper<M, E> {
  E modelToEntity(M model);
  M entityToModel(E entity);
}
