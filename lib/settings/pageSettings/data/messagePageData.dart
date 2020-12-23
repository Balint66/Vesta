import 'package:vesta/datastorage/Lists/holder/listDataHolder.dart';
import 'package:vesta/settings/pageSettingsData.dart';

class MessagePageData extends PageSettingsData
{
  @override
  var interval = MessageListHolder.defaultInterval;

  MessagePageData();

  factory MessagePageData._fromJson(Map<String, dynamic> fromJson)
  {
    return MessagePageData();
  }

}