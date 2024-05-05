extension RichList<E> on List<E> {
  List<B> mapInterpolated<B>(B Function(E) mapper, B interpolation) {
    final result = <B>[];
    final iterator = this.iterator;
    final limit = length - 1;

    for (var i = 0; iterator.moveNext(); i++) {
      result.add(mapper(iterator.current));
      if (i < limit) {
        result.add(interpolation);
      }
    }

    return result;
  }
}
