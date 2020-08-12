part of 'listHolder.dart';

class CalendarListHolder extends ListDataHolder<CalendarDataList>
{



  CalendarListHolder() : super(CalendarDataList(), timespan: Duration(minutes: 10));

  @override
  Future<CalendarDataList> _fetchNewData() async
  {
    var end = DateTime.now().add(Duration(days: 7));

    if(_dataIndex>0)
    {
      end = end.add(Duration(days: 7 * _dataIndex));
    }

    var body = WebDataCalendarRequest(StudentData.Instance,
        endDate: end);

    var resp = await WebServices.getCalendarData(Data.school,
        body);

    ListDataHolder._updateItemCount(resp, this);

    return resp.calendarData;  
  }

}