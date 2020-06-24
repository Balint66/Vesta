import 'dart:collection';

import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/Lists/calendarDataList.dart';
import 'package:vesta/datastorage/Lists/messagesList.dart';
import 'package:vesta/datastorage/Lists/semestersDataList.dart';
import 'package:vesta/datastorage/Lists/studentBookDataList.dart';
import 'package:vesta/datastorage/Lists/subjectDataList.dart';
import 'package:vesta/datastorage/data.dart';
import 'package:vesta/datastorage/studentData.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataCalendarRequest.dart';
import 'package:vesta/web/webdata/webDataCalendarResponse.dart';
import 'package:vesta/web/webdata/webDataMessages.dart';
import 'package:vesta/web/webdata/webDataSemestersRequest.dart';
import 'package:vesta/web/webdata/webDataSubjectRequest.dart';

//only use these to stay organised!
part 'calendarListHolder.dart';
part 'messageListHolder.dart';
part 'studentBookListHolder.dart';
part 'semesterListHolder.dart';
part 'subjectDataListHolder.dart';

typedef ListDataHolderCallback<K> =
Future<K> Function<K extends ListBase>(ListDataHolder<K> self);

class ListDataHolder<T extends ListBase> with BackgroundFetchingServiceMixin
{

  final T _list;
  final ListDataHolderCallback<T> _callback;
  bool _wasData = false;

  int _maxItemCount = 0;
  int get maxItemCount => _maxItemCount;

  static void _updateItemCount(WebDataBase base, ListDataHolder holder)
  {
    holder._maxItemCount = base.TotalRowCount;
  } 

  ListDataHolder(T data, ListDataHolderCallback<T> callback) : this._list = data,
        this._callback = callback;

   Stream<T> getData() async*
  {

    if(_list != null && _list.length != 0)
      yield _list;

    while(true)
    {
      if(_wasData)
      {
        _wasData = false;
        yield _list;
      }

      await Future.delayed(new Duration(seconds: 1));

    }
  }

  @override
  Future<void> onUpdate() async
  {
    T resp = await _callback(this);

    if(resp == null)
      return;

    bool newData = false;

    resp.forEach((element) {
      if(!_list.contains(element))
      {
        _list.add(element);

        if(!newData)
          newData = true;

      }
    });

    _wasData = newData;

  }

  int _neededWeek = 0;

  Future<void> incrementWeeks() async
  {
    _neededWeek++;
    await onUpdate();
  }


}