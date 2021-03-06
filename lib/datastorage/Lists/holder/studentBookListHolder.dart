part of 'listDataHolder.dart';

class StudentBookListHolder extends ListDataHolder<BaseDataList<StudentBookData>>
{

  static final Duration defaultInterval = Duration(days:1);

  StudentBookListHolder({Duration? timespan}) : super(BaseDataList<StudentBookData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<StudentBookData>> _fetchNewData() async 
  {
    var base = WebDataBase.simplified(AccountManager.currentAcount.username,
      AccountManager.currentAcount.password,
      AccountManager.currentAcount.username,
      AccountManager.currentAcount.training.id.toString(),
      LCID: AccountManager.currentAcount.LCID);

    var resp = await WebServices.getStudentBookData(AccountManager.currentAcount.school, base);

    ListDataHolder._updateItemCount(resp!, this);

    return resp.list;

  }
  
}