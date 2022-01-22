
import 'package:i18n_extension/i18n_extension.dart';

extension Localize on String{

  static const _t = Translations.from('en_us',{
    'retry': {
      'en_us': 'Retry',
      'hu': 'Újra próbálkozás',
    },
    'select_school' :{
      'en_us': 'Please select your school!',
      'hu': 'Kérlek válasszad ki az iskoládat!',
    },
    'username': {
      'en_us': 'Username',
      'hu': 'Felhasználónév',
    },
    'username_hint':{
      'en_us': 'Neptun code',
      'hu': 'Neptun kód',
    },
    'username_character_error':{
      'en_us': 'Username must be 6 character long at least!',
      'hu': 'A felhasználónévnek legalább 6 karakterből kell állnia!',
    },
    'password':{
      'en_us': 'Password',
      'hu': 'Jelszó',
    },
    'password_error':{
      'en_us': 'Password must not be empty!',
      'hu': 'A jelszó nem lehet üres!',
    },
    'keepmeloggedin':{
      'en_us': 'Keep me logged in',
      'hu': 'Maradjak bejelentkezve',
    },
    'login_error':{
      'en_us': 'Unable to login!',
      'hu': 'Nem lehetett bejelentkezni!'
    },
    'login':{
      'en_us': 'Login',
      'hu': 'Bejelentkezés',
    },
    'schools':{
      'en_us': 'Schools',
      'hu': 'Iskolák',
    },
    'schools_button':{
      'en_us': 'Schools...',
      'hu': 'Iskolák...',
    },
  });

  String get i18n => localize(this, _t);
}