part of '../pageSettingsBase.dart';

class MessagePageSettings extends PageSettingsBase
{

  MessagePageSettings(String page, PageSettingsData data) : super._(page, data);

  @override
  PageSettingsState<PageSettingsBase> createState() => MessagePageSettingsState();
    
}

class MessagePageSettingsState extends PageSettingsState<MessagePageSettings>
{
  @override
  List<Widget> get body => super.body;
}