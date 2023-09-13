part of core;

abstract class UseCase<T, P>{
  Future<Either<Failure, T>> call([P params]);
}