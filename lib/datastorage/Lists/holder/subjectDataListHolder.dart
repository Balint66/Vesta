part of 'listDataHolder.dart';

class SubjectDataListHolder extends ListDataHolder<BaseDataList<SubjectData>>
{

  static final Duration defaultInterval = Duration(hours:6);

  SubjectDataListHolder(AccountData account, {Duration? timespan}) : super( account, BaseDataList<SubjectData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<SubjectData>> _fetchNewData(AccountData account) async 
  {
    var base = WebDataSubjectRequest(account.webBase);

    var resp = await WebServices.getSubjects(account.school, base);

    ListDataHolder._updateItemCount(resp!.base, this);

    return resp.list;
  }

}