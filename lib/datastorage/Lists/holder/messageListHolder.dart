part of 'listHolder.dart';

class MessageListHolder extends ListDataHolder<MessageList>
{


  MessageListHolder() : super(MessageList(), timespan: Duration(minutes:30));

  @override
  Future<MessageList> _fetchNewData() async
  {
    var body = WebDataBase.simplified(StudentData.Instance.username,
      StudentData.Instance.password,
      StudentData.Instance.username,
      StudentData.Instance.currentTraining.id.toString(),
      currentPage: _dataIndex
  );

  var resp = await WebServices
      .getMessages(Data.school, body);

  ListDataHolder._updateItemCount(resp, this);

  return resp.MessagesList;
  }
}