part of '../pageSettingsBase.dart';

class MessagePageSettings extends PageSettingsBase<MessagePageData>
{

  MessagePageSettings(String page, PageSettingsData data) : super._(page, data as MessagePageData);

  @override
  PageSettingsState<PageSettingsBase> createState() => MessagePageSettingsState();
    
}

class MessagePageSettingsState extends PageSettingsState<MessagePageSettings>
{
  @override
  List<BuildFunction> get body => super.body;
}