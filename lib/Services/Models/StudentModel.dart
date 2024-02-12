
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel{
  final String name;
  final String code;
  final String phone;
  final List<Timestamp> lectures;
  final List<Timestamp> exams;
  StudentModel({required this.name,required this.code,required this.phone ,required this.lectures,required this.exams});
}