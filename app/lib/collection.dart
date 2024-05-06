extension RichList<E> on List<E> {
  List<B> mapInterpolated<B>(B Function(E) mapper, B interpolation,
      {bool addPrev = false, bool addAfter = false}) {
    final result = <B>[];
    final iterator = this.iterator;
    final limit = length - 1;

    if (addPrev) {
      result.add(interpolation);
    }

    for (var i = 0; iterator.moveNext(); i++) {
      result.add(mapper(iterator.current));
      if (i < limit) {
        result.add(interpolation);
      }
    }

    if (addAfter) {
      result.add(interpolation);
    }

    return result;
  }
}
