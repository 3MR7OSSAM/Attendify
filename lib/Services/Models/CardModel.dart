import 'package:flutter/material.dart';
import 'package:student_attendance/Vews/LoginView/LoginView.dart';

import '../../Vews/AddStudentView/AddStudentView.dart';
import '../../Vews/ExamAttendanceView/ExamAttendanceView.dart';
import '../../Vews/LectureAttendanceView/LectureAttendanceView.dart';
import '../../Vews/StudentSearchView/StudentSearchView.dart';

class CustomCardModel {
  final String image;
  final String title;
  final Color color;
  final Widget screen;

  CustomCardModel({required this.image, required this.title, required this.color, required this.screen});
}
List<CustomCardModel> cardsData = [
  CustomCardModel(image: 'assets/images/student_icon.png', title: 'إضافة طالب جديد', color: const Color(0xffE86A33), screen:  const AddStudentView()),
  CustomCardModel(image: 'assets/images/attendance_icon.png', title: 'تسجيل حضور حصة', color: const Color(0xffF0B86E), screen: const LectureAttendanceView()),
  CustomCardModel(image: 'assets/images/exam_icon.png', title: 'تسجيل حضور إمتحان', color: const Color(0xffED7B7B), screen: const ExamAttendanceView()),
  CustomCardModel(image: 'assets/images/search_icon.png', title: 'البحث عن طالب', color: const Color(0xff836096), screen: const StudentSearchView()),
  CustomCardModel(image: 'assets/images/logout_icon.png', title: 'تسجيل الخروج', color: const Color(0xff7B66FF), screen: const LoginViewPage()),
];
