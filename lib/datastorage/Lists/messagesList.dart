import 'dart:collection';

import 'package:vesta/datastorage/message.dart';

class MessageList extends ListBase<Message> implements List<Message>
{

  final List<Message> _l;

  MessageList({List<Message> other}) : this._l = other != null ? other :
    new List<Message>();

  Message operator [](int i) => _l[i];
  void operator []=(int index, Message value) { _l[index] = value; }

  set length(int newLength) { _l.length = newLength; }
  int get length => _l.length;

  @override
  bool contains(Object element)
  {
    if(!(element is Message))
      return false;
    return this.any((e) => e.id == (element as Message).id);
  }
}