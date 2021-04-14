import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamDetailsRequest extends WebDataContainer
{

  @override
  final WebDataBase base;

  final int ExamID;
  final int SubjectID;
  final int ExamType;

  WebDataExamDetailsRequest.studentSimplified(this.base, this.ExamID, {this.ExamType = 1, this.SubjectID = 0});

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