part of 'listHolder.dart';

class SubjectDataListHolder extends ListDataHolder<SubjectDataList>
{


  static Future<K> _updateList<K extends ListBase>(ListDataHolder<K> holder) async
  {
    var base = WebDataSubjectRequest(StudentData.Instance);

    var resp = await WebServices.getSubjects(Data.school, base);

    return resp.list as ListBase;

  }


  SubjectDataListHolder() : super(new SubjectDataList(), _updateList);

}