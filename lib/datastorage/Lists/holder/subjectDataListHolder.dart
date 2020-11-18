part of 'listHolder.dart';

class SubjectDataListHolder extends ListDataHolder<SubjectDataList>
{

  static final Duration defaultInterval = Duration(hours:6);

  SubjectDataListHolder({Duration? timespan}) : super(SubjectDataList(), timespan: timespan ?? defaultInterval);

  @override
  Future<SubjectDataList> _fetchNewData() async 
  {
    var base = WebDataSubjectRequest(StudentData.Instance!);

    var resp = await WebServices.getSubjects(Data.school!, base);

    ListDataHolder._updateItemCount(resp!, this);

    return resp.list;
  }

}