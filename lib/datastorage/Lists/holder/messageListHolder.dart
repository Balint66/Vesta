part of 'listHolder.dart';

class MessageListHolder extends ListDataHolder<MessageList>
{

  static final Duration defaultInterval = Duration(minutes:30);

  MessageListHolder({Duration timespan}) : super(MessageList(), timespan: timespan ?? defaultInterval );

  @override
  Future<MessageList> _fetchNewData() async
  {
    var body = WebDataBase.simplified(StudentData.Instance.username,
      StudentData.Instance.password,
      StudentData.Instance.username,
      StudentData.Instance.currentTraining.id.toString(),
      LCID: StudentData.Instance.LCID,
      currentPage: _dataIndex
  );

  var resp = await WebServices
      .getMessages(Data.school, body);

  ListDataHolder._updateItemCount(resp, this);

  return resp.MessagesList;
  }
}