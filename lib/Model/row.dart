enum TypeCourse { compul, ge, drc, bcc, cc, pc, fex, others }

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
