class CourseData
{
  final String CourseClass;
  final String CourseCode;
  final String CourseTimeTableInfo;
  final String CourseTutor;
  final int CourseType;
  final String CourseType_DNAME;
  final int Id;
  final bool IsJovahagyasos;
  final bool IsRangsoros;
  final bool IsVarolistas;
  final String Letszamok;
  final String RangsorPontszamok;

  CourseData({String CourseClass = "", String CourseCode = "", String CourseTimeTableInfo = "", String CourseTutor = "", int CourseType = 0,
   String CourseType_DNAME = "", int Id = 0, bool IsJovahagyasos = false, bool IsRangsoros = false, bool IsVarolistas = false, String Letszamok = "",
   String RangsorPontszamok = ""}) : this.CourseClass = CourseClass, this.CourseCode = CourseCode, this.CourseTimeTableInfo = CourseTimeTableInfo,
   this.CourseTutor = CourseTutor, this.CourseType = CourseType, this.CourseType_DNAME = CourseType_DNAME, this.Id = Id, this.IsJovahagyasos = IsJovahagyasos,
   this.IsRangsoros = IsRangsoros, this.IsVarolistas = IsVarolistas, this.Letszamok = Letszamok, this.RangsorPontszamok = RangsorPontszamok;

   CourseData.fromJson(Map<String, dynamic> json) : this(CourseClass: json["CourseClass"], CourseCode: json["CourseCode"],
    CourseTimeTableInfo: json["CourseTimeTableInfo"], CourseTutor: json["CourseTutor"], CourseType: json["CourseType"],
    CourseType_DNAME: json["CourseType_DNAME"], Id: json["Id"], IsJovahagyasos: json["IsJovahagyasos"], IsRangsoros: json["IsRangsoros"],
    IsVarolistas: json["IsVarolistas"], Letszamok: json["Letszamok"], RangsorPontszamok: json["RangsorPontszamok"]);

}