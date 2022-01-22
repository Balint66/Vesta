part of 'listDataHolder.dart';

class ExamListHolder extends ListDataHolder<BaseDataList<Exam?>>
{

  ExamListHolder(AccountData account) : super(account, BaseDataList<Exam>());

  @override
  Future<BaseDataList<Exam>> _fetchNewData(AccountData account) async
  {
    var body = WebDataExamRequest.studentSimplified(account.webBase, ExamType: 1);

    var resp = (await WebServices.getExams(account.school, body))!;

    var ls = resp.exams;

    body = WebDataExamRequest.studentSimplified(account.webBase);

    resp = (await WebServices.getExams(account.school, body))!;

    ls.addAll(resp.exams);
    
    return ls;

  }

}