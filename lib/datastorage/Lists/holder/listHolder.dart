import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
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
import 'package:vesta/web/webdata/webDataSemestersRequest.dart';
import 'package:vesta/web/webdata/webDataSubjectRequest.dart';

//only use these to stay organised!
part 'calendarListHolder.dart';
part 'messageListHolder.dart';
part 'studentBookListHolder.dart';
part 'semesterListHolder.dart';
part 'subjectDataListHolder.dart';

abstract class ListDataHolder<T extends ListBase> with BackgroundFetchingServiceMixin
{

  final T _list;
  @override
  final Duration timespan;
  final _streamController = StreamController<T>.broadcast();

  int _maxItemCount = 0;
  int _dataIndex = 1;
  int get maxItemCount => _maxItemCount;

  static void _updateItemCount(WebDataBase base, ListDataHolder holder)
  {
    holder._maxItemCount = base.TotalRowCount;
  } 

  ListDataHolder(T data, {Duration timespan}) : _list = data,
         timespan = timespan ?? Duration();

  @nonVirtual
  Stream<T> getData() 
  {
    Future.delayed(Duration(seconds: 1),() => _streamController.add(_list));
    return _streamController.stream;
  }

    Future<T> _fetchNewData();

  @override
  @nonVirtual
  Future<void> onUpdate() async
  {
    var resp = await _fetchNewData();

    if(resp == null) {
      return;
    }

    var newData = false;

    resp.forEach((element) {
      if(!_list.contains(element))
      {
        _list.add(element);

        if(!newData) {
          newData = true;
        }

      }
    });

    if(newData){
      _streamController.add(_list);
    }

  }


  Future<void> incrementWeeks() async
  {
    _dataIndex++;
    await onUpdate();
  }

}