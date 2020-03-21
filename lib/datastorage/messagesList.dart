import 'package:vesta/datastorage/message.dart';

abstract class MessageList implements List<Message>
{
  @override
  bool contains(Object element)
  {
    if(!(element is Message))
      return false;
    return this.any((e) => e.id == (element as Message).id);
  }
}