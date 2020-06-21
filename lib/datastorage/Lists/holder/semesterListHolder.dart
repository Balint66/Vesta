part of 'listHolder.dart';

class SemesterListHolder extends ListDataHolder<SemestersDataList>
{
  static Future<K> _updateList<K extends ListBase>(ListDataHolder<K> holder) async
  {

    if((holder as SemesterListHolder)._periodtermList == null)
    {

      Vesta.logger.d("So, the list is null? Okay then!");

      var termbase = WebDataBase.studentSimplified(StudentData.Instance);

      (holder as SemesterListHolder)._periodtermList = await WebServices.getPeriodTerms(Data.school, termbase);

    }

    Vesta.logger.d("Now tell me, what is the list? ${(holder as SemesterListHolder)._periodtermList}");

    WebDataSemestersRequest base = WebDataSemestersRequest(StudentData.Instance, PeriodTermID: (holder as SemesterListHolder)._periodtermList[holder._neededWeek]["Id"]);

    var resp = await WebServices.getSemestersData(Data.school, base);

    return resp.list as ListBase;

  }

  List<Map<String, dynamic>> _periodtermList;

  void resetPeridtermList()
  {
    _periodtermList = null;
  }

  SemesterListHolder() : super(new SemestersDataList(), _updateList);

  @override
  Future<void> incrementWeeks() async{}

  List<String> getPeriodTerms() => _periodtermList.map<String>((e)=>e["TermName"].toString()).toList();

  String getCurrentPeriod() => _periodtermList[_neededWeek]["TermName"];

  void setPeriodTermIndex(int index)
  {
    if(index >= 0 && index < _periodtermList.length)
      _neededWeek = index;
  }

}