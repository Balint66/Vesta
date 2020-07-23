import 'dart:convert';

import 'package:vesta/utils/DateUtil.dart';

class PeriodData
{

  final DateTime FromDate;
  final String OrgAdmins;
  final String PeriodName;
  final String PeriodTypeName;
  final DateTime ToDate;
  final int TrainingtermIntervalId; //idk what is this. We should filter by this number and the StudentTrainingID.

  PeriodData({DateTime FromDate = null, String OrgAdmins = "", String PeriodName = "", String PeriodTypeName = "", DateTime ToDate = null, int TrainingtermIntervalId = 0}) 
    : this.FromDate = FromDate == null ? DateTime.now() : FromDate, this.OrgAdmins = OrgAdmins, this.PeriodName = PeriodName,
     this.ToDate = ToDate == null ? DateTime.now() : ToDate, this.TrainingtermIntervalId = TrainingtermIntervalId, this.PeriodTypeName = PeriodTypeName;

    PeriodData.fromJsonString(String str) : this.fromJson(json.decode(str));

    PeriodData.fromJson(Map<String, dynamic> json) 
    : this(FromDate : DateTime.fromMillisecondsSinceEpoch( DateUtil.stripFromMSDateFormat(json["FromDate"])),
      OrgAdmins : json["OrgAdmins"], PeriodName : json["PeriodName"], PeriodTypeName : json["PeriodTypeName"],
      ToDate : DateTime.fromMillisecondsSinceEpoch( DateUtil.stripFromMSDateFormat(json["ToDate"])),
      TrainingtermIntervalId : json["TrainingTermIntervalId"]);


  Map<String, dynamic> toJson()
  {
    return <String,dynamic>{
      "FromDate": "\\/Date(${FromDate.millisecondsSinceEpoch})\\/",
      "OrgAdmins":OrgAdmins,
      "PeridoName": PeriodName,
      "PeriodTypeName": PeriodTypeName,
      "ToDate": "\/Date(${ToDate.millisecondsSinceEpoch})",
      "TrainingTermIntervalId": TrainingtermIntervalId
    };
  }

}