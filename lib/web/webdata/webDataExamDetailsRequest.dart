import 'package:vesta/datastorage/acountData.dart';
import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamDetailsRequest extends WebDataBase
{

  final int ExamID;
  final int SubjectID;
  final int ExamType;

  WebDataExamDetailsRequest.studentSimplified(AccountData data, this.ExamID, {this.ExamType = 1, this.SubjectID = 0}) : super.studentSimplified(data);

  @override
    Map<String, dynamic> toJsonMap() {
      
      var ls = <String, dynamic>{
        'filter': <String, dynamic>{
          'ExamID': ExamID,
          'SubjectID': SubjectID,
          'ExamType': ExamType,
        }
      };

      ls.addAll(super.toJsonMap());

      return ls;
    }

}