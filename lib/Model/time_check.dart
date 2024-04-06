import 'package:flutter/material.dart';

String parseTime(String timeText, BuildContext context) {
  final days = <String>[];
  final periods = <String>[];

  for (int i = 0; i < timeText.length; i++) {
    final letter = timeText[i];
    if (i % 2 == 0) {
      try {
        days.add(getDay(letter));
      } catch (e) {
        return 'Invalid day letter';
      }
    } else {
      try {
        periods.add(getPeriod(letter));
      } catch (e) {
        return 'Invalid period letter';
      }
    }
  }
  if (days.isEmpty || periods.isEmpty || days.length != periods.length) {
    return 'Invalid time, please try again';
  }
  return '';
}

String getDay(String letter) {
  switch (letter) {
    case 'M':
    case 'T':
    case 'W':
    case 'R':
    case 'F':
    case 'S':
    case 'U':
      return letter;
    default:
      throw const FormatException('Invalid day letter');
  }
}

String getPeriod(String letter) {
  switch (letter) {
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case 'a':
    case 'b':
    case 'c':
      return letter;
    default:
      throw const FormatException('Invalid period letter');
  }
}
