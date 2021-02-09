part of 'listDataHolder.dart';

class ExamListHolder extends ListDataHolder<BaseDataList<Exam>>
{

  ExamListHolder() : super(BaseDataList<Exam>());

  @override
  Future<BaseDataList<Exam>> _fetchNewData() async
  {
    var body = WebDataExamRequest.studentSimplified(AccountManager.currentAcount, ExamType: 1);

    var resp = (await WebServices.getExams(AccountManager.currentAcount.school, body))!;

    var ls = resp.exams;

    body = WebDataExamRequest.studentSimplified(AccountManager.currentAcount);

    resp = (await WebServices.getExams(AccountManager.currentAcount.school, body))!;

    ls.addAll(resp.exams);
    
    return ls;

  }

}