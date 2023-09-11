extension IterableExtension<T, R> on Iterable<R> {
  List<R> distinctList() => toSet().toList();

  List<T> distinctListWithMap(T Function(R) mapFunction) =>
      map(mapFunction).toSet().toList();

  List<T> distinctListWithMapWhere(
    bool Function(R) whereFunction,
    T Function(R) mapFunction,
  ) =>
      where(whereFunction).map(mapFunction).toSet().toList();
}
