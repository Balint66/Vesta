
import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String{

  static const _t = Translations.from('en_us', {
    'lessons_title':{
      'en_us':'Title',
      'hu':'Név',
    },
    'lessons_desc':{
      'en_us':'Description',
      'hu':'Leírás',
    },
    'lessons_loc':{
      'en_us':'Location',
      'hu':'Helyszín',
    },
    'lessons_start':{
      'en_us':'Starting date',
      'hu':'Kezdete',
    },
    'lessons_end':{
      'en_us':'Ending date',
      'hu':'Vége',
    },
    'lessons_aday':{
      'en_us':'All day long',
      'hu':'Egésznapos',
    },
    'lessons_type':{
      'en_us':'Type',
      'hu':'Típusa',
    },
    'lessons_id':{
      'en_us':'ID',
      'hu':'ID',
    },
    'lessons_cl':{
      'en_us':'Color',
      'hu':'Szín',
    }
  });

  String get i18n => localize(this, _t);
}