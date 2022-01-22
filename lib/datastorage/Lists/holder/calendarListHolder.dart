part of 'listDataHolder.dart';

class CalendarListHolder extends ListDataHolder<BaseDataList<CalendarData?>>
{

  static final Duration defaultInterval = Duration(minutes:10);

  CalendarListHolder(AccountData account, {Duration? timespan}) : super(account, BaseDataList<CalendarData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<CalendarData>> _fetchNewData(AccountData account) async
  {
    var start = DateTime.now().add(Duration(days: 7 * (_dataIndex-1)));
    var end = start.add(Duration(days: 7));

    var body = WebDataCalendarRequest(account.webBase,
        starDate: start, endDate: end);

    var resp = await WebServices.getCalendarData(account.school,
        body);

    ListDataHolder._updateItemCount(resp!.base, this);

    return resp.calendarData;  
  }

  void setDataIndex(int index) async
  {
    var old = _dataIndex;
    _dataIndex = index;
    if(old != _dataIndex)
    {
      await onUpdate();
    }
  }

}