class DateUtil
{

  static int minutesToSeconds(int minute)
  {
    return minute * 60;
  }

  static int hoursToMinutes(int hours)
  {
    return hours * 60;
  }

  static int daysToHours(int days)
  {
    return days * 24;
  }

  static int weeksToDays(int weeks)
  {
    return weeks * 7;
  }

  static int hoursToSeconds(int hours)
  {
    return minutesToSeconds(hoursToMinutes(hours));
  }

  static int daysToMinutes(int days)
  {
    return hoursToMinutes(daysToHours(days));
  }

  static int weeksToHours(int weeks)
  {
    return daysToHours(weeksToDays(weeks));
  }

  static int daysToSeconds(int days)
  {
    return hoursToSeconds(daysToHours(days));
  }

  static int weeksToMinutes(int weeks)
  {
    return daysToMinutes(weeksToDays(weeks));
  }

  static int weeksToSeconds(int weeks)
  {
    return minutesToSeconds(weeksToMinutes(weeks));
  }
  
  static int epochFlooredToMinutes(DateTime time)
  {
    return time.subtract(Duration(seconds: time.second, milliseconds: time.millisecond,
            microseconds: time.microsecond)).millisecondsSinceEpoch;
  }
  
  static int epochFlooredToHours(DateTime time)
  {
    return time.subtract(Duration(minutes: time.minute, seconds: time.second,
            milliseconds: time.millisecond, microseconds: time.microsecond)).millisecondsSinceEpoch;
  }

  static int epochFlooredToDays(DateTime time)
  {
    return time.subtract(Duration(hours: time.hour, minutes: time.minute,
            seconds: time.second, milliseconds: time.millisecond,
            microseconds: time.microsecond)).millisecondsSinceEpoch;
  }

  static int stripFromMSDateFormat(String formattedString)
  {
    return int.tryParse(formattedString.split('(')[1].split(')')[0]) ?? 0;
  }

}