import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:koloplan/data/models/result.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class AppUtils {
  static List<BoxShadow> getBoxShaddow = [
    BoxShadow(
        offset: Offset(0, 1),
        color: Color(0xFF000000).withOpacity(0.06),
        blurRadius: 8)
  ];
  static List<BoxShadow> getBoxShaddowBank = [
    BoxShadow(
        offset: Offset(0, 5.3),
        color: Color(0xFF000000).withOpacity(0.07),
        blurRadius: 14.3)
  ];
  static List<BoxShadow> getBoxShaddow3 = [
    BoxShadow(
        offset: Offset(0, 16),
        color: Color(0xFF000000).withOpacity(0.10),
        blurRadius: 43)
  ];
  static List<BoxShadow> getBoxShaddow2 = [
    BoxShadow(
        offset: Offset(0, 0.05),
        color: Color(0xFF000000).withOpacity(0.03),
        blurRadius: 2)
  ];

  static var states = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];

  static String getReadableTime(DateTime date) {
    var time = TimeOfDay.fromDateTime(date);

    if (date.hour == 12 || date.hour == 0) {
      var timeString = "12"
          ":${addPreceedingZero(time.minute.toString())}"
          "${time.period == DayPeriod.pm ? ' PM' : ' AM'}";
      return timeString;
    } else {
      var timeString = "${addPreceedingZero(time.hourOfPeriod.toString())}"
          ":${addPreceedingZero(time.minute.toString())}"
          "${time.period == DayPeriod.pm ? ' PM' : ' AM'}";
      return timeString;
    }
  }

  static String addPreceedingZero(String data) {
    if (data.length == 1) {
      return "0$data";
    } else {
      return data;
    }
  }

  static String getDayString(int value) {
    if (value == 1) {
      return 'Monday';
    }
    if (value == 2) {
      return 'Tuesday';
    }
    if (value == 3) {
      return 'Wednesday';
    }
    if (value == 4) {
      return 'Thurday';
    }
    if (value == 5) {
      return 'Friday';
    }
    if (value == 6) {
      return 'Saturday';
    }
    if (value == 7) {
      return 'Sunday';
    }

    return value.toString();
  }

  static String getDayStringSec(int value) {
    if (value == 1) {
      return 'Mon';
    }
    if (value == 2) {
      return 'Tue';
    }
    if (value == 3) {
      return 'Wed';
    }
    if (value == 4) {
      return 'Thur';
    }
    if (value == 5) {
      return 'Fri';
    }
    if (value == 6) {
      return 'Sat';
    }
    if (value == 7) {
      return 'Sun';
    }

    return value.toString();
  }

  static String convertToMillionAbbr(String value) {
    var removeComma = value.split(",").join();
    if(removeComma.length <= 6) {
      return value;
    } else if(removeComma.length == 7) {
      if(num.tryParse(removeComma[2]) == 0) {
        return removeComma[0] +"."+ removeComma[1]+"M";
      } else {
        return removeComma[0] +"."+ removeComma[1]+removeComma[2]+"M";
      }
    } else if(removeComma.length == 8) {
      return removeComma[0] + removeComma[1]+"."+removeComma[2]+"M";
    } else if(removeComma.length == 9) {
      return removeComma[0] + removeComma[1]+removeComma[2]+"."+removeComma[3]+"M";
    } else if(removeComma.length == 10) {
      if(num.tryParse(removeComma[2]) == 0) {
        return removeComma[0] +"."+ removeComma[1]+"B";
      } else {
        return removeComma[0] +"."+ removeComma[1]+removeComma[2]+"B";
      }
    } else if(removeComma.length == 11) {
      return removeComma[0] + removeComma[1]+"."+removeComma[2]+"B";
    } else if(removeComma.length == 12) {
      return removeComma[0] + removeComma[1]+removeComma[2]+"."+removeComma[3]+"B";
    } else if(removeComma.length == 13) {
      return removeComma[0] +"."+ removeComma[1]+"Tn";
    }

    return value;
  }

  static String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  static String getMonthStringFull(int value) {
    if (value == 1) {
      return 'January';
    }
    if (value == 2) {
      return 'Febuary';
    }
    if (value == 3) {
      return 'March';
    }
    if (value == 4) {
      return 'April';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'June';
    }
    if (value == 7) {
      return 'July';
    }
    if (value == 8) {
      return 'August';
    }
    if (value == 9) {
      return 'September';
    }
    if (value == 10) {
      return 'October';
    }
    if (value == 11) {
      return 'November';
    }
    if (value == 12) {
      return 'December';
    }
    return value.toString();
  }

  static String getMonthStringSemi(int value) {
    if (value == 1) {
      return 'Jan';
    }
    if (value == 2) {
      return 'Feb';
    }
    if (value == 3) {
      return 'Mar';
    }
    if (value == 4) {
      return 'Apr';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'Jun';
    }
    if (value == 7) {
      return 'Jul';
    }
    if (value == 8) {
      return 'Aug';
    }
    if (value == 9) {
      return 'Sep';
    }
    if (value == 10) {
      return 'Oct';
    }
    if (value == 11) {
      return 'Nov';
    }
    if (value == 12) {
      return 'Dec';
    }
    return value.toString();
  }

  static getReadableDate(DateTime time) {
    return "${getDayString(time.weekday)}, ${addLeadingZeroIfNeeded(time.day)} ${getMonthStringFull(time.month)}";
  }

  static getReadableDate2(DateTime time) {
    // print("ppppopooppo ${time}");
    return "${addLeadingZeroIfNeeded(time.day)} ${getMonthStringSemi(time.month)}, ${time.year}";
  }

  static getReadableDate5(DateTime time) {
    var now = DateTime.now();
    if(time.year != now.year) {
      return "${addLeadingZeroIfNeeded(time.day)} ${getMonthStringSemi(time.month)} ${time.year}";
    } else {
      return "${addLeadingZeroIfNeeded(time.day)} ${getMonthStringSemi(time.month)}";
    }
  }

  static getReadableDate4(DateTime time) {
    print("ppppopooppo ${time}");
    return "${addLeadingZeroIfNeeded(time.weekday)}";
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String daysBetweenToString(int differenceInDays) {
    String daysDifference = "";
    switch(differenceInDays) {
      case 0:
        daysDifference = "Today";
        break;
      case 1:
        daysDifference = "Yesterday";
        break;
      case 2:
        daysDifference = "2 days ago";
        break;
      case 3:
        daysDifference = "3 days ago";
        break;
      case 4:
        daysDifference = "4 days ago";
        break;
      case 5:
        daysDifference = "5 days ago";
        break;
      case 6:
        daysDifference = "6 days ago";
        break;
      case 7:
        daysDifference = "7 days ago";
        break;
      default:
        daysDifference = "Date";
        break;
    }
    return daysDifference;
  }

  static getWeekday(int weekday) {
    String weekdayToString = "";
    switch(weekday) {
      case 1:
        weekdayToString = "Mon";
        break;
      case 2:
        weekdayToString = "Tue";
        break;
      case 3:
        weekdayToString = "Wed";
        break;
      case 4:
        weekdayToString = "Thu";
        break;
      case 5:
        weekdayToString = "Fri";
        break;
      case 6:
        weekdayToString = "Sat";
        break;
      case 7:
        weekdayToString = "Sun";
        break;
    }
    return weekdayToString;
  }

  static getReadableDate3(DateTime time) {
    // print("ppppopooppoo ${time}");
    return "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${addLeadingZeroIfNeeded(time.hour)}:${addLeadingZeroIfNeeded(time.minute)}:${addLeadingZeroIfNeeded(time.second)}"))}";
  }

  static getReadableDateShort(DateTime time) {
    return "${Jiffy(time).format("do MMMM, yyyy")}";
  }

  static bool isSuccessStatusCode(int code) {
    return code <= 200 && 209 >= code;
  }

  static Result formatDioException(DioError e) {
    Result result = new Result(
        error: true, errorMessage: "Sorry, we couldn't complete your request");
    if (e.response != null) {
      print(e.response.data);
      if (e.response.data['message'] is String) {
        result.errorMessage = e.response.data['message'];
      }
    } else {
      print(e.toString());
      result.errorMessage = "Sorry, We could not complete your request";
    }

    return result;
  }

  static String getDayWithSuffix(int time) {
    String timeString = time.toString();
    if (timeString.endsWith("1")) {
      return "${time}st";
    } else if (timeString.endsWith("2")) {
      return "${time}nd";
    } else if (timeString.endsWith("3")) {
      return "${time}rd";
    } else {
      return "${time}th";
    }
  }
}

extension DurationUtils on int {
  Duration seconds() {
    return Duration(seconds: this);
  }
}
// extension CurrencyUtils on doustrble {
//    seconds() {
//     return Duration(seconds: this);
//   }
// }

extension StringUtils on String {
  String convertWithComma() {
    String value = this;
    var buffer = new StringBuffer();
    if(value == "" || value == null) {
      return "0";
    } else {
      if (value.length == 4) {
        buffer.write(value[0]);
        buffer.write(',');
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(value[3]);
      } else if (value.length == 5) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(',');
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(value[4]);
      } else if (value.length == 6) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(',');
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(value[5]);
      } else if (value.length == 7) {
        buffer.write(value[0]);
        buffer.write(',');
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(',');
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(value[6]);
      } else if (value.length == 8) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(',');
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(',');
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(value[7]);
      } else if (value.length == 9) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(',');
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(',');
        buffer.write(value[6]);
        buffer.write(value[7]);
        buffer.write(value[8]);
      } else if (value.length == 10) {
        buffer.write(value[0]);
        buffer.write(',');
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(',');
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(',');
        buffer.write(value[7]);
        buffer.write(value[8]);
        buffer.write(value[9]);
      } else if (value.length == 11) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(',');
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(',');
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(value[7]);
        buffer.write(',');
        buffer.write(value[8]);
        buffer.write(value[9]);
        buffer.write(value[10]);
      } else if (value.length == 12) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(',');
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(',');
        buffer.write(value[6]);
        buffer.write(value[7]);
        buffer.write(value[8]);
        buffer.write(',');
        buffer.write(value[9]);
        buffer.write(value[10]);
        buffer.write(value[11]);
      } else if (value.length == 13) {
        buffer.write(value[0]);
        buffer.write(',');
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(',');
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(',');
        buffer.write(value[7]);
        buffer.write(value[8]);
        buffer.write(value[9]);
        buffer.write(',');
        buffer.write(value[10]);
        buffer.write(value[11]);
        buffer.write(value[12]);
      } else if (value.length == 14) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(',');
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(',');
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(value[7]);
        buffer.write(',');
        buffer.write(value[8]);
        buffer.write(value[9]);
        buffer.write(value[10]);
        buffer.write(',');
        buffer.write(value[11]);
        buffer.write(value[12]);
        buffer.write(value[13]);
      } else if (value.length == 15) {
        buffer.write(value[0]);
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(',');
        buffer.write(value[3]);
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(',');
        buffer.write(value[6]);
        buffer.write(value[7]);
        buffer.write(value[8]);
        buffer.write(',');
        buffer.write(value[9]);
        buffer.write(value[10]);
        buffer.write(value[11]);
        buffer.write(',');
        buffer.write(value[12]);
        buffer.write(value[13]);
        buffer.write(value[14]);
      } else if (value.length == 16) {
        buffer.write(value[0]);
        buffer.write(',');
        buffer.write(value[1]);
        buffer.write(value[2]);
        buffer.write(value[3]);
        buffer.write(',');
        buffer.write(value[4]);
        buffer.write(value[5]);
        buffer.write(value[6]);
        buffer.write(',');
        buffer.write(value[7]);
        buffer.write(value[8]);
        buffer.write(value[9]);
        buffer.write(',');
        buffer.write(value[10]);
        buffer.write(value[11]);
        buffer.write(value[12]);
        buffer.write(',');
        buffer.write(value[13]);
        buffer.write(value[14]);
        buffer.write(value[15]);
      }
        else {
        for (int i = 0; i < value.length; i++) {
          // print('lllllf $i');
          buffer.write(value[i]);
          var nonZeroIndex = i + 1;

          if (nonZeroIndex % 3 == 0 && nonZeroIndex != value.length) {
            buffer.write(',');
          }
        }
      }

      return "${buffer.toString()}";
    }
  }
}
