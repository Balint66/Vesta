part of 'listDataHolder.dart';

class StudentBookListHolder extends ListDataHolder<BaseDataList<StudentBookData>>
{

  static final Duration defaultInterval = Duration(days:1);

  StudentBookListHolder({Duration? timespan}) : super(BaseDataList<StudentBookData>(), timespan: timespan ?? defaultInterval);
  
  @override
  Future<void> incrementDataIndex() async{}

  @override
  Future<BaseDataList<StudentBookData>> _fetchNewData() async 
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