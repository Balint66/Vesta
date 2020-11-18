part of 'listHolder.dart';

class StudentBookListHolder extends ListDataHolder<StudentBookDataList>
{

  static final Duration defaultInterval = Duration(days:1);

  StudentBookListHolder({Duration? timespan}) : super(StudentBookDataList(), timespan: timespan ?? defaultInterval);
  
  @override
  Future<void> incrementWeeks() async{}

  @override
  Future<StudentBookDataList> _fetchNewData() async 
  {
    var base = WebDataBase.simplified(StudentData.Instance!.username,
      StudentData.Instance!.password,
      StudentData.Instance!.username,
      StudentData.Instance!.currentTraining!.id.toString(),
      LCID: StudentData.Instance!.LCID);

    var resp = await WebServices.getStudentBookData(Data.school!, base);

    ListDataHolder._updateItemCount(resp!, this);

    return resp.list;

  }
  
}