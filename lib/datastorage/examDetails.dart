import 'package:vesta/utils/DateUtil.dart';

class ExamDetails
{
    final bool IsSuccess;
    final DateTime Created;
    final String Creator;
    final String Description;
    final String ExactedRoom;
    final DateTime? ExactedTime;
    final int? ExamCode;
    final String? ExamName;
    final String ExamRooms;
    final String ExamType_DNAME;
    final String FromDate;
    final String MaxStrength;
    final String MinStrength;
    final String SigninToDate;
    final String SigninFromDate;
    final int Strength;
    final String ToDate;
    final int WaitingListCount;
    final int WaitingStrength;

  ExamDetails(this.IsSuccess, this.Created, this.Creator, this.Description, this.ExactedRoom,
    this.ExactedTime, this.ExamCode, this.ExamName, this.ExamRooms, this.ExamType_DNAME,
    this.FromDate, this.MaxStrength, this.MinStrength, this.SigninToDate, this.SigninFromDate,
    this.Strength, this.ToDate, this.WaitingListCount, this.WaitingStrength);

  factory ExamDetails.fromJson(Map<String, dynamic> json)
  {
    return ExamDetails(json['IsSuccess'], DateTime.fromMillisecondsSinceEpoch(DateUtil.stripFromMSDateFormat(json['Created'])), json['Creator'], json['Description'], json['ExactedRoom'],
            json['ExactedTime'], json['ExamCode'], json['ExamName'], json['ExamRooms'], json['ExamType_DNAME'], json['FromDate'],
            json['MaxStrength'], json['MinStrength'], json['SigninToDate'], json['SigninFromDate'], json['Strength'], json['ToDate'],
            json['WaitingListCount'], json['WaitingStrength']);
  }

}