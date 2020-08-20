part of 'listHolder.dart';

class SemesterListHolder extends ListDataHolder<SemestersDataList>
{

  List<Map<String, dynamic>> _periodtermList = <Map<String, dynamic>>[];

  void resetPeridtermList()
  {
    _periodtermList = <Map<String, dynamic>>[];
  }

  SemesterListHolder() : super(SemestersDataList(), timespan: Duration(days: 1));

  @override
  Future<void> incrementWeeks() async{}

  Future<List<String>> getPeriodTerms() async
  { 
    
    await Future.doWhile(() async
    {

      if(_periodtermList != null && _periodtermList.isNotEmpty) {
        return false;
      }
      
      await Future.delayed(Duration(milliseconds: 50));

      return true;

    });
    
    return _periodtermList.map<String>((e)=>e['TermName'].toString()).toList();

  }

  Future<String> getCurrentPeriod() async
  {

    await Future.doWhile(() async
    {

      if(_periodtermList != null && _periodtermList.isNotEmpty) {
        return false;
      }
      
      await Future.delayed(Duration(milliseconds: 50));

      return true;

    });
    
    return _periodtermList[_dataIndex]['TermName'];

  }

  void setPeriodTermIndex(int index)
  {
    if(index >= 0 && index < _periodtermList.length) {
      _dataIndex = index;
    }
  }


  @override
  Future<void> onUpdate() async //ignore:invalid_override_of_non_virtual_member
  {
    _list.removeWhere((element) => true);
    _list.addAll( await _fetchNewData());
    if(_list.isNotEmpty) {
      _streamController.add(_list);
    }  
  }

  @override
  Future<SemestersDataList> _fetchNewData() async
  {

    if(_periodtermList == null || _periodtermList.isEmpty)
    {

      Vesta.logger.d('So, the list is null? Okay then!');

      var termbase = WebDataBase.studentSimplified(StudentData.Instance);

      _periodtermList = await WebServices.getPeriodTerms(Data.school, termbase);

    }

    Vesta.logger.d('Now tell me, what is the list? ${_periodtermList}');

    var base = WebDataSemestersRequest(StudentData.Instance, PeriodTermID: _periodtermList[_dataIndex]['Id']);

    var resp = await WebServices.getSemestersData(Data.school, base);

    ListDataHolder._updateItemCount(resp, this);

    return resp.list;
  }

}