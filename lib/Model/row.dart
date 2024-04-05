enum Category { compul, ge, drc, bcc, cc, pc, fex }

class Course {
  final String type;
  final String courseName;
  final String credit;
  final String time;

  Course({
    required this.type,
    required this.courseName,
    required this.credit,
    required this.time,
  });
}
