part of 'listDataHolder.dart';

class SubjectDataListHolder extends ListDataHolder<BaseDataList<SubjectData>>
{

  static final Duration defaultInterval = Duration(hours:6);

  SubjectDataListHolder({Duration? timespan}) : super(BaseDataList<SubjectData>(), timespan: timespan ?? defaultInterval);

  @override
  Future<BaseDataList<SubjectData>> _fetchNewData() async 
  {
    var base = WebDataSubjectRequest(AccountManager.currentAcount);

    var resp = await WebServices.getSubjects(AccountManager.currentAcount.school, base);

    ListDataHolder._updateItemCount(resp!.base, this);

    return resp.list;
  }

}