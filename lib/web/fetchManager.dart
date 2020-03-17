import 'package:vesta/web/backgroundFetchingServiceMixin.dart';

class FetchManager
{
  static List<BackgroundFetchingServiceMixin> _services = new List<BackgroundFetchingServiceMixin>();

  factory FetchManager._() => null;

  static void register(BackgroundFetchingServiceMixin mixin)
  {
    if(!_services.contains(mixin))
    {
      _services.add(mixin);
      mixin.onUpdate();
    }
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