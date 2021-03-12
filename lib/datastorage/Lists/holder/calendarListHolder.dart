part of 'listDataHolder.dart';

class CalendarListHolder extends ListDataHolder<BaseDataList<CalendarData>>
{

  static final Duration defaultInterval = Duration(minutes:10);

  CalendarListHolder({Duration? timespan}) : super(BaseDataList<CalendarData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<CalendarData>> _fetchNewData() async
  {
    var start = DateTime.now().add(Duration(days: 7 * (_dataIndex-1)));
    var end = start.add(Duration(days: 7));

    var body = WebDataCalendarRequest(AccountManager.currentAcount.webBase,
        starDate: start, endDate: end);

    var resp = await WebServices.getCalendarData(AccountManager.currentAcount.school,
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