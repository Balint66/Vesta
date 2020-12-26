import 'package:vesta/utils/DateUtil.dart';

class Exam 
{
  final String CourseCode;
  final int? CourseExam_ExamSigninID;
  final int CourseID;
  final int ExamID;
  final String ExamType;
  final DateTime FromDate;
  final String? SignedIn;
  final String SubjectCode;
  final int SubjectID;
  final String SubjectName;
  final DateTime ToDate;

  final int FilterExamType;

  Exam(this.CourseCode, this.CourseExam_ExamSigninID, this.CourseID, this.ExamID, this.ExamType, this.FromDate, this.SignedIn,
    this.SubjectCode, this.SubjectID, this.SubjectName, this.ToDate, this.FilterExamType);

  factory Exam.fromJson(Map<String, dynamic> json, int FilterExamType) 
    => Exam(json['CourseCode'], json['CourseExam_ExamSigninID'], json['CourseID'], json['ExamID'], json['ExamType'],
            DateTime.fromMillisecondsSinceEpoch(DateUtil.stripFromMSDateFormat(json['FromDate'])), json['SignedIn'],
            json['SubjectCode'], json['SubjectID'], json['SubjectName'],
            DateTime.fromMillisecondsSinceEpoch(DateUtil.stripFromMSDateFormat(json['ToDate'])), FilterExamType);

  @override
  bool operator ==(Object other) {
    return other is Exam && other.SubjectID == SubjectID && other.CourseID == CourseID && other.ExamID == ExamID;
  }



}