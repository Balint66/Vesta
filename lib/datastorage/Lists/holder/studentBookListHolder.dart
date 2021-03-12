part of 'listDataHolder.dart';

class StudentBookListHolder extends ListDataHolder<BaseDataList<StudentBookData>>
{

  static final Duration defaultInterval = Duration(days:1);

  StudentBookListHolder({Duration? timespan}) : super(BaseDataList<StudentBookData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<StudentBookData>> _fetchNewData() async 
  {

    var resp = await WebServices.getStudentBookData(AccountManager.currentAcount.school, SimpleConatiner(AccountManager.currentAcount.webBase));

    ListDataHolder._updateItemCount(resp!.base, this);

    return resp.list;

  }
  
}