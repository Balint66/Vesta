import 'package:vesta/web/webdata/webDataBase.dart';

class WebDataExamSignupResponse extends WebDataBase
{

  final bool IsSucces;
  final String? Message;
  final bool NeedExamIdentifier;

  WebDataExamSignupResponse.fromJson(Map<String, dynamic> json) : IsSucces = json['examSigningData']['IsSucces'],
    Message = json['examSigningData']['Message'], NeedExamIdentifier = json['examSigningData']['NeedExamIdentifier'], super.fromJson(json);

}