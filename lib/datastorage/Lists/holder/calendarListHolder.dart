part of 'listHolder.dart';

class CalendarListHolder extends ListDataHolder<CalendarDataList>
{

  static Future<K> _updateList<K extends ListBase>(ListDataHolder<K> holder) async
  {
    DateTime end = DateTime.now().add(new Duration(days: 7));

    if(holder._neededWeek>0)
    {
      end = end.add(new Duration(days: 7 * holder._neededWeek));
    }

    WebDataCalendarRequest body = new WebDataCalendarRequest(StudentData.Instance,
        endDate: end);

    WebDataCalendarResponse resp = await WebServices.getCalendarData(Data.school,
        body);

    ListDataHolder._updateItemCount(resp, holder);

    return resp.calendarData as ListBase;
  }

  CalendarListHolder() : super(new CalendarDataList(), _updateList, timespan: new Duration(minutes: 10));

}