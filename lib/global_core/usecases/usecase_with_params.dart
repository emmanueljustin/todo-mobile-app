abstract class UseCaseWithParams<T, P>{
  Future<(String?, T?)> call(P params);
}