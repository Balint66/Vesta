import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:vesta/Vesta.dart';
import 'package:vesta/datastorage/Lists/basedataList.dart';
import 'package:vesta/datastorage/calendarData.dart';
import 'package:vesta/datastorage/examData.dart';
import 'package:vesta/datastorage/message.dart';
import 'package:vesta/datastorage/periodData.dart';
import 'package:vesta/datastorage/studentBookData.dart';
import 'package:vesta/datastorage/subjectData.dart';
import 'package:vesta/managers/accountManager.dart';
import 'package:vesta/web/backgroundFetchingServiceMixin.dart';
import 'package:vesta/web/webServices.dart';
import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataCalendarRequest.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';
import 'package:vesta/web/webdata/webDataExamRequest.dart';
import 'package:vesta/web/webdata/webDataSemestersRequest.dart';
import 'package:vesta/web/webdata/webDataSubjectRequest.dart';

//only use these to stay organised!
part 'calendarListHolder.dart';
part 'messageListHolder.dart';
part 'studentBookListHolder.dart';
part 'semesterListHolder.dart';
part 'subjectDataListHolder.dart';
part 'examListHolder.dart';

typedef IncrementFunction = Future<void> Function();

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
  @nonVirtual
  late final IncrementFunction incrementDataIndex;

  int _maxItemCount = -255;
  late int _dataIndex;
  int get maxItemCount => _maxItemCount;

  static void _updateItemCount(WebDataBase base, ListDataHolder holder)
  {
    holder._maxItemCount = base.TotalRowCount;
  } 

  ListDataHolder(T data, {Duration? timespan, bool hasDataIndex = true}) : _list = data,
        _timespan = timespan ?? Duration()
        {
          if(hasDataIndex)
          {
            _dataIndex = 1;
            incrementDataIndex = () async
              {
                _dataIndex++;
                await onUpdate();
              };
          } 
          else
          {
            incrementDataIndex = () async {};
          }

        }

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

  @nonVirtual
  void enableFetch()
  {
    _enabled = true;
  }

  @nonVirtual
  void disableFetch()
  {
    _enabled = false;
  }

  @nonVirtual
  void updateInterval(Duration interval)
  {
    if(interval.isNegative|| interval.inSeconds < 0)
    {
      return;
    }

    _timespan = interval;

  }

}