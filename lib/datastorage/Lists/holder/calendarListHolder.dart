part of 'listDataHolder.dart';

class CalendarListHolder extends ListDataHolder<BaseDataList<CalendarData>>
{

  static final Duration defaultInterval = Duration(minutes:10);

  CalendarListHolder({Duration? timespan}) : super(BaseDataList<CalendarData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<CalendarData>> _fetchNewData() async
  {
    var end = DateTime.now().add(Duration(days: 7));

    if(_dataIndex>0)
    {
      end = end.add(Duration(days: 7 * _dataIndex));
    }

    var body = WebDataCalendarRequest(AccountManager.currentAcount,
        endDate: end);

    var resp = await WebServices.getCalendarData(AccountManager.currentAcount.school,
        body);

    ListDataHolder._updateItemCount(resp!, this);

    return resp.calendarData;  
  }

}