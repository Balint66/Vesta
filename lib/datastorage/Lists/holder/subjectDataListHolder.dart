part of 'listHolder.dart';

class SubjectDataListHolder extends ListDataHolder<SubjectDataList>
{

  SubjectDataListHolder() : super(SubjectDataList(), timespan: Duration(days:1));

  @override
  Future<SubjectDataList> _fetchNewData() async 
  {
    var base = WebDataSubjectRequest(StudentData.Instance);

    var resp = await WebServices.getSubjects(Data.school, base);

    ListDataHolder._updateItemCount(resp, this);

    return resp.list;
  }

}