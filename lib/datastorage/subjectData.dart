import 'dart:convert';

class SubjectData
{
  final bool Completed;
  final int Credit;
  final int CurriculumTemplateID;
  final int CurriculumTemplatelineID;
  bool IsOnSubject;
  final String SubjectCode;
  final int SubjectId;
  final String SubjectName;
  final String SubjectRequirement;
  final String SubjectSignupType;
  final int TermID;


  SubjectData({bool Completed = false, int Credit = 0, int CurriculumTemplateID = 0, int CurriculumTemplatelineID = 0, bool IsOnSubject = false,
    String SubjectCode = '', int SubjectId = 0, 
    String SubjectName = '', String SubjectRequirement = '', String SubjectSignupType = '', int TermID = 0}) 
    : Completed = Completed, Credit = Credit, CurriculumTemplateID = CurriculumTemplateID, CurriculumTemplatelineID = CurriculumTemplatelineID,
      IsOnSubject = IsOnSubject, SubjectCode = SubjectCode, SubjectId = SubjectId, SubjectName = SubjectName,
      SubjectRequirement = SubjectRequirement, SubjectSignupType = SubjectSignupType, TermID = TermID;

    SubjectData.fromJsonString(String str) : this.fromJson(json.decode(str));

    SubjectData.fromJson(Map<String, dynamic> json) 
    : this(Completed: json['Completed'], Credit: int.tryParse(json['Credit'].toString()), CurriculumTemplateID: json['CurriculumTemplateID'],
      CurriculumTemplatelineID: json['CurriculumTemplatelineID'], IsOnSubject: json['IsOnSubject'], SubjectCode: json['SubjectCode'],
      SubjectId: json['SubjectId'], SubjectName: json['SubjectName'], SubjectRequirement: json['SubjectRequirement'], 
      SubjectSignupType: json['SubjectSignupType'], TermID: json['TermID']);

    Map<String, dynamic> toJson()
    {
      return <String,dynamic>{
        'Completed': Completed,
        'Credit' : Credit,
        'CurriculumTemplateID' : CurriculumTemplateID,
        'CurriculumTemplatelineID' : CurriculumTemplatelineID,
        'IsOnSubject' : IsOnSubject,
        'SubjectCode' : SubjectCode,
        'SubjectId' : SubjectId,
        'SubjectName' : SubjectName,
        'SubjectRequirement' : SubjectRequirement,
        'SubjectSignupType' : SubjectSignupType,
        'TermID' : TermID
        
      };
    }

}