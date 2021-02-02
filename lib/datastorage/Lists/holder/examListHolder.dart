part of 'listDataHolder.dart';

class ExamListHolder extends ListDataHolder<BaseDataList<Exam>>
{

  ExamListHolder() : super(BaseDataList<Exam>());

  @override
  Future<BaseDataList<Exam>> _fetchNewData() async
  {
    var body = WebDataExamRequest.studentSimplified(StudentData.Instance, ExamType: 1);

    var resp = (await WebServices.getExams(Data.school!, body))!;

    var ls = resp.exams;

    body = WebDataExamRequest.studentSimplified(StudentData.Instance);

    resp = (await WebServices.getExams(Data.school!, body))!;

    ls.addAll(resp.exams);

    //ListDataHolder._updateItemCount(resp!, this);

    return ls;

  }

}