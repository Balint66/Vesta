import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
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

abstract class ListDataHolder<T extends BaseDataList> with BackgroundFetchingServiceMixin
{

  final T _list;
  @override
  Duration get timespan => _timespan;
  Duration _timespan;
  @override
  bool get enabled => _enabled;
  bool _enabled = true;
  final _streamController = StreamController<T>.broadcast();

  int _maxItemCount = -255;
  int _dataIndex = 1;
  int get maxItemCount => _maxItemCount;

  static void _updateItemCount(WebDataBase base, ListDataHolder holder)
  {
    holder._maxItemCount = base.TotalRowCount;
  } 

  ListDataHolder(T data, {Duration? timespan}) : _list = data,
        _timespan = timespan ?? Duration();

  @nonVirtual
  Stream<T> getData() 
  {
    Future.delayed(Duration(seconds: 1),() {if(_list.isNotEmpty) _streamController.add(_list);});
    return _streamController.stream;
  }

  Future<T> _fetchNewData();

  @override
  @nonVirtual
  Future<void> onUpdate() async
  {
    var resp = await _fetchNewData();

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

  void enableFetch()
  {
    _enabled = true;
  }

  void disableFetch()
  {
    _enabled = false;
  }

  void updateInterval(Duration interval)
  {
    if(interval.isNegative|| interval.inSeconds < 0)
    {
      return;
    }

    _timespan = interval;

  }


  Future<void> incrementWeeks() async
  {
    _dataIndex++;
    await onUpdate();
  }

}