abstract class UseCaseWithNoParams<T>{
  Future<(String?, T?)> call();
}