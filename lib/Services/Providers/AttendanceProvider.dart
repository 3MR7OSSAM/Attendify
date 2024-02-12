import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AttendanceProvider extends ChangeNotifier{
  Future<void> lectureAttendance({required String studentCode , required DateTime date})async{
    final student = FirebaseFirestore.instance.collection('students').doc(studentCode);
      await student.update({
        'lectures' : FieldValue.arrayUnion([
          date
        ])
      });

  }
  Future<void> examAttendance({required String studentCode , required DateTime date})async{
    final student = FirebaseFirestore.instance.collection('students').doc(studentCode);
      await student.update({
        'exams' : FieldValue.arrayUnion([
          date
        ])
      });
  }
}