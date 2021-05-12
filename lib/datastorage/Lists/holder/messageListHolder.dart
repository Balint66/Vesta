part of 'listDataHolder.dart';

class MessageListHolder extends ListDataHolder<BaseDataList<Message>>
{

  static final Duration defaultInterval = Duration(minutes:30);

  MessageListHolder(AccountData account, {Duration? timespan}) : super(account, BaseDataList<Message>(), timespan: timespan ?? defaultInterval );

  @override
  Future<BaseDataList<Message>> _fetchNewData(AccountData account) async
  {

  var resp = await WebServices
      .getMessages(account.school,
        SimpleConatiner(account.webBase,
        CurrentPage: _dataIndex, LCID: SettingsManager.settings.neptunLang));

  ListDataHolder._updateItemCount(resp.base, this);

  return resp.MessagesList;
  }
}