part of 'listDataHolder.dart';

class MessageListHolder extends ListDataHolder<BaseDataList<Message>>
{

  static final Duration defaultInterval = Duration(minutes:30);

  MessageListHolder({Duration? timespan}) : super(BaseDataList<Message>(), timespan: timespan ?? defaultInterval );

  @override
  Future<BaseDataList<Message>> _fetchNewData() async
  {

  var resp = await WebServices
      .getMessages(AccountManager.currentAcount.school,
        SimpleConatiner(AccountManager.currentAcount.webBase,
        CurrentPage: _dataIndex, LCID: SettingsManager.settings.neptunLang));

  ListDataHolder._updateItemCount(resp.base, this);

  return resp.MessagesList;
  }
}