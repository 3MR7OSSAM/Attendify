import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance/Services/Models/StudentModel.dart';
import 'package:student_attendance/Services/Providers/StudentProvider.dart';
import 'package:student_attendance/Vews/Widgets/DropDownMenu.dart';
import 'package:student_attendance/Vews/Widgets/customFormField.dart';

import '../../Services/Methods/ShowBtmAlert.dart';
import '../../Services/Methods/ShowDialog.dart';
import '../StudentDetailsView/StudentDetailsView.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/StudentInfoWidget.dart';

class StudentSearchView extends StatefulWidget {
  const StudentSearchView({Key? key}) : super(key: key);

  @override
  State<StudentSearchView> createState() => _StudentSearchViewState();
}

class _StudentSearchViewState extends State<StudentSearchView> {
  late TextEditingController codeController;
  String dropdownValue = "الكود";
  int selectionMethod = 0;
  final TextEditingController _searchTextController = TextEditingController();
  List<StudentModel> filteredStudents = [];

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  _filteredStudents(List<StudentModel> students, int selectionMethod) {
    String searchValue = _searchTextController.text;
    return students.where((element) {
      if (searchValue.isEmpty) {
        return true; // Show all students if the search value is empty
      } else {
        if (selectionMethod == 0) {
          return element.code.contains(searchValue);
        } else if (selectionMethod == 1) {
          return element.name.contains(searchValue);
        } else {
          return element.phone.contains(searchValue);
        }
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.get_students;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(
                isMain: false,
                title: 'البحث عن طالب',
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFormField(
                        controller: _searchTextController,
                        onChanged: (value) {
                          setState(() {
                            // Update the filteredStudents list when the search text changes
                            filteredStudents =
                                _filteredStudents(students, selectionMethod);
                          });
                        },
                        hintText: dropdownValue,
                        obscureText: false,
                        isNumber: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: MyDropdown(
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (dropdownValue == 'الكود') {
                            selectionMethod = 0;
                          } else if (dropdownValue == 'الاسم') {
                            selectionMethod = 1;
                          } else {
                            selectionMethod = 2;
                          }
                        });
                      },
                      dropdownValue: dropdownValue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.76,
                child: ListView.builder(
                  itemCount: _searchTextController.text.isEmpty
                      ? students.length
                      : filteredStudents.length,
                  itemBuilder: (builder, index) {
                    return InkWell(
                      onLongPress: () async {
                        await showLogoutDialog(
                            context, '', 'هل تريد حذف الطالب ؟', () async {
                          try {
                            final code = _searchTextController.text.isEmpty
                                ? students[index].code
                                : filteredStudents[index].code;
                            await FirebaseFirestore.instance
                                .collection('students')
                                .doc(code)
                                .delete();
                            studentProvider.get_students
                                .remove(students[index]);
                            setState(() {
                              // Update the students list when a student is deleted
                              studentProvider.get_students;
                            });
                          } catch (e) {
                            context.mounted
                                ? showBtmAlert(context, e.toString(), 600)
                                : null;
                          }
                          context.mounted ? Navigator.pop(context) : null;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentDetailsView(index: index),
                          ),
                        );
                      },
                      child: StudentInfoWidget(
                        name: _searchTextController.text.isEmpty
                            ? students[index].name
                            : filteredStudents[index].name,
                        code: _searchTextController.text.isEmpty
                            ? students[index].code
                            : filteredStudents[index].code,
                        phone: _searchTextController.text.isEmpty
                            ? students[index].phone
                            : filteredStudents[index].phone,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
