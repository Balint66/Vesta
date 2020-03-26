part of 'listHolder.dart';

class MessageListHolder extends ListDataHolder<MessageList>
{

  static Future<K> _listUpdater<K extends ListBase>(ListDataHolder<K> holder) async
  {

  WebDataBase body = WebDataBase.simplified(StudentData.Instance.username,
      StudentData.Instance.password,
      StudentData.Instance.username,
      StudentData.Instance.currentTraining.id.toString(),
      currentPage: holder._neededWeek
  );

  WebDataMessages resp = await WebServices
      .getMessages(Data.school, body);

  return resp.MessagesList as ListBase;
  }

  MessageListHolder() : super(new MessageList(), _listUpdater);
}