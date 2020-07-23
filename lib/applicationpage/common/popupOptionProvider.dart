import 'package:flutter/material.dart';

class PopupOptionProviderWidget extends InheritedWidget
{

  final PopupOptionProviderFunction _provider;

  PopupOptionProviderWidget({Key key, @required Widget child, @ required PopupOptionProviderFunction data})
    : this._provider = data, super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)
  {
    return true;
  }

  static PopupOptionProviderFunction of(BuildContext context, {bool rebuild = true})
  {
    if(rebuild)
      return context.dependOnInheritedWidgetOfExactType<PopupOptionProviderWidget>()._provider;
    else
      return context.findAncestorWidgetOfExactType<PopupOptionProviderWidget>()._provider;
  }
  
}

class PopupOptionData
{

  final PopupMenuItemBuilder<int> builder;
  final PopupMenuItemSelected<int> selector;

  PopupOptionData({@required PopupMenuItemBuilder<int> builder, @required PopupMenuItemSelected<int> selector}) 
    : this.builder = builder, this.selector = selector; 

}

mixin PopupOptionProvider
{

  PopupOptionData getOptions();

  void setOptions(PopupMenuItemBuilder<int> builder, PopupMenuItemSelected<int> selector);

}

typedef PopupOptionProviderFunction = PopupOptionProvider Function();
