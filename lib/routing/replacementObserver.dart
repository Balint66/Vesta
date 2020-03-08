import 'package:flutter/widgets.dart';

class ReplacementObserver extends NavigatorObserver
{

  Map<String,Set<ReplacementAware>> _listeners = new Map<String,Set<ReplacementAware>>();

  void subscribe(ReplacementAware aware, String route)
  {
    assert(route!=null);
    assert(aware!=null);
    //assert(route.isEmpty);

    final Set<ReplacementAware> set = _listeners.putIfAbsent(route, () => <ReplacementAware>{}); // ignore: sdk_version_set_literal


  }

  @override
  void didReplace({Route newRoute, Route oldRoute})
  {

    Set<ReplacementAware> subs = _listeners[newRoute.settings.name];

    if(subs != null)
    {
      for(ReplacementAware i in subs)
        i.didReplaceOther(oldRoute: oldRoute);
    }
    else
    {

      subs = _listeners[oldRoute.settings.name];

      if(subs != null)
        for(ReplacementAware i in subs)
          i.wasReplacedBy(otherRoute: newRoute);

    }

    super.didReplace(newRoute:newRoute,oldRoute:oldRoute);
  }

}

abstract class ReplacementAware
{
  factory ReplacementAware() => null;

  didReplaceOther({Route oldRoute});

  wasReplacedBy({Route otherRoute});

}