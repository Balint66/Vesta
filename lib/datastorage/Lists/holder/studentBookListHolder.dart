part of 'listDataHolder.dart';

class StudentBookListHolder extends ListDataHolder<BaseDataList<StudentBookData>>
{

  static final Duration defaultInterval = Duration(days:1);

  StudentBookListHolder(AccountData account, {Duration? timespan}) : super(account, BaseDataList<StudentBookData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<StudentBookData>> _fetchNewData(AccountData account) async 
  {

    var resp = await WebServices.getStudentBookData(account.school, SimpleConatiner(account.webBase));

    ListDataHolder._updateItemCount(resp!.base, this);

    return resp.list;

  }
  
}