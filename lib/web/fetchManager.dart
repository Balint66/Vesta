import 'package:vesta/web/backgroundFetchingServiceMixin.dart';

abstract class FetchManager
{
  
  static final _services = <BackgroundFetchingServiceMixin>[];

  static bool _inFront = true;
  static Future<void> _loop = Future.doWhile(() async
  {

    await Future.delayed(Duration(minutes: 5));

    await fetch();

    return _inFront;
  });

  static void stopFrontFetch()
  {
    _inFront = false;
  }

  static void startFrontFetch()
  {
    _inFront = true;
    _loop = Future.doWhile(() async
    {
      await Future.delayed(Duration(minutes: 5));

      await fetch();

      return _inFront;
    });
  }

  static void init()
  {
    _inFront = true; //Just to be safe
    _loop.then((value) => null);
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
    for(var i = 0; i< _services.length; i++) {
      _services.removeAt(i);
    }
  }

  static Future<void> fetch() async
  {
    for(var item in _services)
    {

      if(!item.enabled){
        continue;
      }

      if(DateTime.now().difference(item.lastFetch) >= item.timespan)
      {

          item.lastFetch = DateTime.now();
          await item.onUpdate();
      }
    }
  }

  static Future<void> forceFetch() async
  {
    for(var item in _services)
    {
      
      item.lastFetch = DateTime.now();
      await item.onUpdate();
      
    }
  }

}