import 'package:flutter/widgets.dart';
import 'package:vesta/applicationpage/innerMainProgRouter.dart';

class ReplacementObserver extends NavigatorObserver
{

  static final Instance = ReplacementObserver(); // ignore: non_constant_identifier_names

  final _listeners = <String,Set<ReplacementAware>>{};

  var currentPath = '';

  void subscribe(ReplacementAware aware, String route)
  {
    assert(route!=null);
    assert(aware!=null);
    assert(route.isNotEmpty);

    var set = Set<ReplacementAware>(); // ignore:prefer_collection_literals

    set.add(aware);

    if(_listeners.containsKey(route)){
      set.addAll(_listeners.remove(route));
    }

      _listeners.putIfAbsent(route, () => set); // ignore: sdk_version_set_literal

  }

  @override
  void didPush(Route route, Route previousRoute) {
    didReplace(newRoute: route, oldRoute: previousRoute);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route newRoute, Route oldRoute})
  {

    if(!(newRoute is PageRoute && oldRoute is PageRoute))
    {
      if(currentPath.isEmpty) {
        currentPath = MainProgRouter.defaultRoute;
      }
      return;
    }

    if(newRoute != null && oldRoute != null && newRoute.settings.name == oldRoute.settings.name) {
      return super.didReplace(newRoute:newRoute,oldRoute:oldRoute);
    }

    Set<ReplacementAware> subs;

    if(newRoute != null)
    {
      currentPath = newRoute.settings.name;
      subs = _listeners[newRoute.settings.name];
    }

    if(subs != null)
    {
      for(var i in subs) {
        i.didReplaceOther(oldRoute: oldRoute);
      }
    }

    if(oldRoute != null) {
      subs = _listeners[oldRoute.settings.name];
    }

    if(subs != null)
    {
        for(var i in subs) {
          i.wasReplacedBy(otherRoute: newRoute);
        }

    }

    super.didReplace(newRoute:newRoute,oldRoute:oldRoute);
  }

}

abstract class ReplacementAware
{
  factory ReplacementAware() => null;

  void didReplaceOther({Route oldRoute});

  void wasReplacedBy({Route otherRoute});

}