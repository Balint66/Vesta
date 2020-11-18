import 'dart:collection';

import 'package:flutter/foundation.dart';

abstract class BaseDataList<T> extends ListBase<T> implements List<T>
{
  final List<T> _l;

  @mustCallSuper
  BaseDataList({List<T>? other}) : _l = other ?? <T>[];

  @override
  @nonVirtual
  T operator [](int i) => _l[i];
  @override
  void operator []=(int index, T value) => _l[index] = value;

  @override
  @nonVirtual
  set length(int newLength) => _l.length = newLength;

  @override
  @nonVirtual
  int get length => _l.length;

  @override
  bool contains(Object? element) => element != null && any( (e) => e == element);

}