part of 'listHolder.dart';

class StudentBookListHolder extends ListDataHolder<StudentBookDataList>
{

  static Future<K> _updateList<K extends ListBase>(ListDataHolder<K> holder) async
  {
    WebDataBase base = WebDataBase.simplified(StudentData.Instance.username,
      StudentData.Instance.password,
      StudentData.Instance.username,
      StudentData.Instance.currentTraining.id.toString());

    var resp = await WebServices.getStudentBookData(Data.school, base);

    return resp.list as ListBase;

  }

  StudentBookListHolder() : super(new StudentBookDataList(), _updateList);
  
}