part of 'listHolder.dart';

class SemesterListHolder extends ListDataHolder<SemestersDataList>
{
  static Future<K> _updateList<K extends ListBase>(ListDataHolder<K> holder) async
  {

    if((holder as SemesterListHolder)._periodtermList == null || (holder as SemesterListHolder)._periodtermList.isEmpty)
    {

      Vesta.logger.d("So, the list is null? Okay then!");

      var termbase = WebDataBase.studentSimplified(StudentData.Instance);

      (holder as SemesterListHolder)._periodtermList = await WebServices.getPeriodTerms(Data.school, termbase);

    }

    Vesta.logger.d("Now tell me, what is the list? ${(holder as SemesterListHolder)._periodtermList}");

    WebDataSemestersRequest base = WebDataSemestersRequest(StudentData.Instance, PeriodTermID: (holder as SemesterListHolder)._periodtermList[holder._neededWeek]["Id"]);

    var resp = await WebServices.getSemestersData(Data.school, base);

    ListDataHolder._updateItemCount(resp, holder);

    return resp.list as ListBase;

  }

  List<Map<String, dynamic>> _periodtermList = new List<Map<String, dynamic>>();

  void resetPeridtermList()
  {
    _periodtermList = new List<Map<String, dynamic>>();
  }

  SemesterListHolder() : super(new SemestersDataList(), _updateList, timespan: new Duration(days: 1));

  @override
  Future<void> incrementWeeks() async{}

  Future<List<String>> getPeriodTerms() async
  { 
    
    await Future.doWhile(() async
    {

      if(_periodtermList != null && _periodtermList.isNotEmpty)
        return false;
      
      await Future.delayed(new Duration(milliseconds: 50));

      return true;

    });
    
    return _periodtermList.map<String>((e)=>e["TermName"].toString()).toList();

  }

  Future<String> getCurrentPeriod() async
  {

    await Future.doWhile(() async
    {

      if(_periodtermList != null && _periodtermList.isNotEmpty)
        return false;
      
      await Future.delayed(new Duration(milliseconds: 50));

      return true;

    });
    
    return _periodtermList[_neededWeek]["TermName"];

  }

  void setPeriodTermIndex(int index)
  {
    if(index >= 0 && index < _periodtermList.length)
      _neededWeek = index;
  }

}