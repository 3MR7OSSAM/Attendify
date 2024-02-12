import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance/Vews/Widgets/ColorSpecifier.dart';
import 'package:student_attendance/Vews/Widgets/CustomAppBar.dart';
import '../../Services/Providers/StudentProvider.dart';
import '../Widgets/DateCard.dart';
class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.get_students;
    final student = students[index];
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppBar(
              isMain: false,
              title: 'بيانات الطالب :',
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 8),
              child: Text(student.name,
                  style: const TextStyle(
                      fontSize: 18, decoration: TextDecoration.underline)),
            ),
            const ColorSpecifier(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 250,
                height: 1,
                decoration: const BoxDecoration(color: Colors.black12),
              ),
            ),
            student.lectures.isNotEmpty
                ? Column(
                    children: [
                      Text('حضر الطالب  ${student.lectures.length} حصص '),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * .35,
                          child: GridView.builder(
                              //physics: const NeverScrollableScrollPhysics(),
                              itemCount: student.lectures.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4, childAspectRatio: 1),
                              itemBuilder: (builder, index) {
                                return DateCard(
                                  date: student.lectures[index].toDate(),
                                  isExam: false,
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 250,
                          height: 1,
                          decoration:
                              const BoxDecoration(color: Colors.black12),
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'الطالب لم يحضر حصص من قبل !',
                    style: TextStyle(color: Colors.black),
                  ),
            student.exams.isNotEmpty
                ? Column(
                    children: [
                      Text('حضر الطالب  ${student.exams.length} إمتحانات '),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * .4,
                          child: GridView.builder(
                              //physics: const NeverScrollableScrollPhysics(),
                              itemCount: student.exams.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4, childAspectRatio: 1),
                              itemBuilder: (builder, index) {
                              //  final date = getTime(time: student.exams[index]);
                                return DateCard(
                                  date: student.exams[index].toDate(),
                                  isExam: true,
                                );
                              }),
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'الطالب لم إمتحانات  من قبل !',
                    style: TextStyle(color: Colors.black),
                  ),
          ],
        ),
      ),
    ));
  }

}
