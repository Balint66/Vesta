import 'package:vesta/web/webdata/webDataBase.dart';
import 'package:vesta/web/webdata/webDataContainer.dart';

class WebDataExamSignupResponse extends WebDataContainer
{

  @override
  final WebDataBase base;

  final bool IsSucces;
  final String? Message;
  final bool NeedExamIdentifier;

  WebDataExamSignupResponse.fromJson(Map<String, dynamic> json) : IsSucces = json['examSigningData']['IsSucces'],
    Message = json['examSigningData']['Message'], NeedExamIdentifier = json['examSigningData']['NeedExamIdentifier'],
    base = WebDataBase.fromJson(json);

  @override
  Map<String, dynamic> toJsonMap() {
    throw UnimplementedError();
  }

}