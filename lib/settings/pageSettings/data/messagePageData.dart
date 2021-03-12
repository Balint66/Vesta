import 'package:vesta/datastorage/Lists/holder/listDataHolder.dart';
import 'package:vesta/settings/pageSettingsData.dart';

class MessagePageData extends PageSettingsData
{
  @override
  var interval = MessageListHolder.defaultInterval;

  MessagePageData();

  factory MessagePageData.fromJson(Map<String, dynamic> fromJson)
  {
    return MessagePageData();
  }

  @override
  Map<String, dynamic> toJson() {
    var base = super.toJson();
    base['type'] = 'message';
    return base;
  }

}