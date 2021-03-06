part of 'listDataHolder.dart';

class MessageListHolder extends ListDataHolder<BaseDataList<Message>>
{

  static final Duration defaultInterval = Duration(minutes:30);

  MessageListHolder({Duration? timespan}) : super(BaseDataList<Message>(), timespan: timespan ?? defaultInterval );

  @override
  Future<BaseDataList<Message>> _fetchNewData() async
  {
    var body = WebDataBase.simplified(AccountManager.currentAcount.username,
      AccountManager.currentAcount.password,
      AccountManager.currentAcount.username,
      AccountManager.currentAcount.training.id.toString(),
      LCID: AccountManager.currentAcount.LCID,
      currentPage: _dataIndex
  );

  var resp = await WebServices
      .getMessages(AccountManager.currentAcount.school, body);

  ListDataHolder._updateItemCount(resp, this);

  return resp.MessagesList;
  }
}