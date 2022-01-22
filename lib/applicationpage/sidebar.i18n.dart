import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String{

  static const _t = Translations.from('en_us', {
    'messages':{
      'en_us': 'Messages',
      'hu': 'Üzenetek',
    },
    'forum':{
      'en_us': 'Forums',
      'hu': 'Fórumok',
    },
    'calendar':{
      'en_us': 'Calendar',
      'hu': 'Naptár',
    },
    'subjects':{
      'en_us': 'Subjects',
      'hu': 'Tárgyak',
    },
    'exams':{
      'en_us': 'Exams',
      'hu': 'Vizsgák',
    },
    'student_book':{
      'en_us': 'Mark Book',
      'hu': 'Lecke könyv',
    },
    'semesters':{
      'en_us': 'Semesters',
      'hu': 'Szemeszterek',
    },
    'settings':{
      'en_us': 'Settings',
      'hu': 'Beállítások',
    }
  });

  String get i18n => localize(this, _t);
}