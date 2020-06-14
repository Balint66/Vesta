import 'dart:convert';

class StudentBookData
{
    final bool Completed;
    final int Credit;
    final String ID;
    final String SubjectName;
    final String Values;

    StudentBookData({bool Completed = false, int Credit = 0, String ID = "", String SubjectName = "", Values = ""}) 
    : this.Completed = Completed, this.Credit = Credit, this.ID = ID, this.SubjectName = SubjectName, this.Values = Values;

    StudentBookData.fromJsonString(String str) : this.fromJson(json.decode(str));

    StudentBookData.fromJson(Map<String, dynamic> json) 
    : this(Completed : json["Completed"], Credit : json["Credit"], ID : json["ID"].toString(), SubjectName : json["SubjectName"], Values : json["Values"]);

    Map<String, dynamic> toJson()
    {
      return <String,dynamic>{
        "Completed":Completed,
        "Credit":Credit,
        "ID":ID,
        "SubjectName":SubjectName,
        "Values":Values
      };
    }

}