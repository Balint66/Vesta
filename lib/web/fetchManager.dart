import 'package:vesta/web/backgroundFetchingServiceMixin.dart';

class FetchManager
{
  static List<BackgroundFetchingServiceMixin> _services = new List<BackgroundFetchingServiceMixin>();

  factory FetchManager._() => null;

  static bool _inFront = true;
  static Future<void> _loop = Future.doWhile(() async
  {

    await Future.delayed(new Duration(seconds: 15));

    await fetch();

    return _inFront;
  });

  static void stopFrontFetch()
  {
    _inFront = false;
  }

  static void init()
  {
    _inFront = true; //Just to be safe
  }

  static void register(BackgroundFetchingServiceMixin mixin)
  {
    if(!_services.contains(mixin))
    {
      _services.add(mixin);
      mixin.onUpdate();
    }
  }

  static void deregister(BackgroundFetchingServiceMixin mixin)
  {
    if(_services.contains(mixin))
    {
      _services.remove(mixin);
    }
  }

  static void clearRegistered()
  {
    for(var mixin in _services)
      _services.remove(mixin);
  }

  static Future<void> fetch() async
  {
     for(var item in _services)
     {
       if(item.lastFetch == null)
       {
         item.lastFetch = DateTime.now();
         item.onUpdate();
       }
       else if(DateTime.now().difference(item.lastFetch) >= item.timespan)
       {
         item.lastFetch = DateTime.now();
          item.onUpdate();
        }
     }
  }

}