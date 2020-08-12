part of 'listHolder.dart';

class StudentBookListHolder extends ListDataHolder<StudentBookDataList>
{

  StudentBookListHolder() : super(StudentBookDataList(), timespan: Duration(days:1));
  
  @override
  Future<void> incrementWeeks() async{}

  @override
  Future<StudentBookDataList> _fetchNewData() async 
  {
    var base = WebDataBase.simplified(StudentData.Instance.username,
      StudentData.Instance.password,
      StudentData.Instance.username,
      StudentData.Instance.currentTraining.id.toString());

    var resp = await WebServices.getStudentBookData(Data.school, base);

    ListDataHolder._updateItemCount(resp, this);

    return resp.list;

  }
  
}