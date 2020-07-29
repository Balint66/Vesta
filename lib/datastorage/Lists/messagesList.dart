import 'dart:collection';

import 'package:vesta/datastorage/message.dart';

class MessageList extends ListBase<Message> implements List<Message>
{

  final List<Message> _l;

  MessageList({List<Message> other}) : _l = other ?? <Message>[];

  @override
  Message operator [](int i) => _l[i];
  @override
  void operator []=(int index, Message value) { _l[index] = value; }

  @override
  set length(int newLength) { _l.length = newLength; }
  @override
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is Message)) {
      return false;
    }
    return any((e) => e.id == (element as Message).id);
  }
}