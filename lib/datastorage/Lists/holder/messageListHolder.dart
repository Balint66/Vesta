part of 'listDataHolder.dart';

class MessageListHolder extends ListDataHolder<BaseDataList<Message>>
{

  static final Duration defaultInterval = Duration(minutes:30);

  MessageListHolder({Duration? timespan}) : super(BaseDataList<Message>(), timespan: timespan ?? defaultInterval );

  @override
  Future<BaseDataList<Message>> _fetchNewData() async
  {
    var body = WebDataBase.simplified(StudentData.Instance!.username,
      StudentData.Instance!.password,
      StudentData.Instance!.username,
      StudentData.Instance!.currentTraining!.id.toString(),
      LCID: StudentData.Instance!.LCID,
      currentPage: _dataIndex
  );

  var resp = await WebServices
      .getMessages(Data.school!, body);

  ListDataHolder._updateItemCount(resp, this);

  return resp.MessagesList;
  }
}