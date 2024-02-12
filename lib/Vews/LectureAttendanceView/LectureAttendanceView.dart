import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance/Services/Providers/StudentProvider.dart';

import '../../Services/Methods/ShowBtmAlert.dart';
import '../../Services/Providers/AttendanceProvider.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/customFormField.dart';

class LectureAttendanceView extends StatefulWidget {
  const LectureAttendanceView({Key? key}) : super(key: key);

  @override
  State<LectureAttendanceView> createState() => _LectureAttendanceViewState();
}

class _LectureAttendanceViewState extends State<LectureAttendanceView> {
  late TextEditingController codeController;

  //bool isCameraDisables = true;
  String? code;
  DateTime? selectedDate;
  String? qrStr;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
          body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                isMain: false,
                title: 'تسجيل حضور حصة',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: 220,
                height: 1.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(16)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('تاريخ الحصة',
                    style: TextStyle(
                        color: Colors.black87.withOpacity(0.8), fontSize: 20)),
              ),
              DatePicker(
                daysCount: 30,
                width: width * 0.18,
                height: height * 0.13,
                DateTime.now().subtract(const Duration(days: 3)),
                selectionColor: Colors.black,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              SizedBox(height: height * 0.03),
              Padding(
                      padding: EdgeInsets.only(bottom: height * 0.04),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: width * 0.8,
                              child: CustomFormField(
                                controller: codeController,
                                onChanged: (codeValue) {
                                  setState(() {
                                    code = codeController.text;
                                  });
                                },
                                hintText: 'كود الطالب ',
                                obscureText: false,
                                isNumber: true,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: scanQr,
                              icon: const Icon(
                                Icons.qr_code,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () async{
                        try{
                          if(code == null){
                            showBtmAlert(context , 'برجاء إدخال الكود',600);
                          }else{
                            setState(() {
                              isLoading = true;
                            });

                            final date = selectedDate ?? DateTime.now();
                            final timestamp = Timestamp.fromDate(date);

                            bool isDateExists = studentProvider.get_students.firstWhere((student) => student.code == code).lectures.any((element) =>element.toDate().day  == date.day);
                            if (!isDateExists) {
                              studentProvider.get_students.firstWhere((element) => element.code == code).lectures.add(timestamp);
                              await attendanceProvider.lectureAttendance(studentCode: code!, date: selectedDate ?? DateTime.now());
                              context.mounted?showBtmAlert(context , 'تم تسجيل الحضور',600):null;
                            }else{
                              context.mounted?showBtmAlert(context , 'الطالب مسجل بالفعل',600):null;
                            }
                          }
                          setState(() {
                            isLoading = false;
                            codeController.clear();
                          });
                        }catch(e){
                          print(e.toString());
                        context.mounted?showBtmAlert(context , 'حدث خطأ ما برجاء المحاولة مرة أخري',600):null;
                        }finally{
                          setState(() {
                            isLoading = false;
                          });
                        }                    },
                      child: const Text(
                       'تسجيل الحضور',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: width * .08,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                      // isCameraDisables = true;
                          codeController.clear();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          'تجاهل',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ],
          ),
                ),
              ),
        ));
  }
  DateTime getTime({required Timestamp time}) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
        time.seconds * Duration.microsecondsPerSecond +
            (time.nanoseconds / 1000).round());
    return dateTime;
  }
  Future <void>scanQr()async{
    try{
      FlutterBarcodeScanner.scanBarcode('#E86A33', 'cancel', false, ScanMode.QR).then((value){
        if(value.length > 3){
          codeController.text = value.toString();
        }

        setState(() {
          code =value;
          qrStr=value;
        });
      });
    }catch(e){
      setState(() {
        qrStr='unable to read this';
      });
    }
  }

}
