import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Methods/ShowBtmAlert.dart';
import '../Models/StudentModel.dart';

class StudentProvider extends ChangeNotifier{

List<StudentModel> _students = [];

bool _hasErrors = false;


List<StudentModel> get get_students{
  return _students;
}
bool get getStatus {
  return _hasErrors;
}

Future<void> getStudents(context) async {
  print('getting students...');
  _students.clear();
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .get(const GetOptions(source: Source.server));

    for (var element in querySnapshot.docs) {
      _students.insert(
        0,
        StudentModel(
          name: element.get('name') ?? 'name',
          code: element.get('code') ?? 'code',
          phone: element.get('phone') ?? 'phone',
          // Explicitly cast 'lectures' and 'exams' to List<Timestamp>
          lectures: (element.get('lectures') as List<dynamic>?)
              ?.map((timestamp) => (timestamp as Timestamp))
              .toList() ??
              <Timestamp>[],
          exams: (element.get('exams') as List<dynamic>?)
              ?.map((timestamp) => (timestamp as Timestamp))
              .toList() ??
              <Timestamp>[],
        ),
      );
    }
    _hasErrors = false;
    notifyListeners();
  } catch (e) {
    _hasErrors = true;
    print(e.toString());
    //  context.mounted ? showBtmAlert(context,'حدث خطأ ما أثناء جلب البيانات براجاء المحاولة مرة اخري',600): null;
  }
}

  Future<void> addStudent({required String name,required String code,required String phone})async{
    try {
      await FirebaseFirestore.instance.collection('students').doc(code).set({
        'name': name,
        'code': code,
        'phone': phone,
        'lectures':[],
        'exams':[],
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}