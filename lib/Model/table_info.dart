List<List<String>> dataTable = List.generate(12, (_) => List.filled(12, ''));

void updateTable(String courseName, String time) {
  int k = 0;
  int flag1 = 0;
  int flag2 = 0;
  int rowIndex = -1;
  int colIndex = -1;
  for (int i = 0; i < time.length; i++) {
    if (i % 2 == 0) {
      rowIndex = parseText(time[i]);
      flag1 = 1;
    } else {
      colIndex = parseText(time[i]);
      flag2 = 1;
    }
    k = (k + 1) % 2;
    if (k == 0 && flag1 == 1 && flag2 == 1) {
      dataTable[colIndex][rowIndex] = courseName;
    }
  }
}

int parseText(String text) {
  switch (text) {
    case 'M':
      return 0;
    case 'T':
      return 1;
    case 'W':
      return 2;
    case 'R':
      return 3;
    case 'F':
      return 4;
    case 'S':
      return 5;
    case 'U':
      return 6;
    case 'a':
      return 10;
    case 'b':
      return 11;
    case 'c':
      return 12;
    default:
      return int.parse(text);
  }
}
