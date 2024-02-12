import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance/Services/Models/StudentModel.dart';
import '../../Services/Methods/ShowBtmAlert.dart';
import '../../Services/Providers/StudentProvider.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/customFormField.dart';

class AddStudentView extends StatefulWidget {

   const AddStudentView({Key? key}) : super(key: key);

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  late  TextEditingController codeController ;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading =false;
  String? qrStr;
  String name ='';
  String code ='';
  String phone ='';
  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController= TextEditingController();
    phoneController= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final studentsProvider = Provider.of<StudentProvider>(context);

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return   SafeArea(
      child: ModalProgressHUD(
       // color: Colors.deepOrange,
        inAsyncCall: isLoading,
        child: Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomAppBar(isMain: false, title: 'إضافة طالب ',),
                  SizedBox(
                    height: height*0.06,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width *0.8,
                          child: CustomFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الحقل مطلوب';
                              }
                              return null;
                            },
                            controller: codeController, onChanged: (codeValue) {
                              code = codeValue;
                          }, hintText: 'كود الطالب ', obscureText: false, isNumber: true,),
                        ),
                      ),
                      InkWell(
                          onTap: scanQr,
                          child: const Icon(Icons.qr_code,size: 30,))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormField(
              
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                      controller: nameController, onChanged: (nameValue) {
                        name = nameValue;
                    }, hintText: 'اسم الطالب', obscureText: false, isNumber: false,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                      controller: phoneController, onChanged: (phoneValue) {
                        phone = phoneValue;
                    }, hintText: 'رقم الهاتف ', obscureText: false, isNumber: true,),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue
                          ),
                          onPressed: ()async{
              
                            final form = formKey.currentState;
                              if(form!.validate()){
                               try {
                                 setState(() {
                                   isLoading = true;
                                 });
                                 bool isStudentExists = studentsProvider.get_students.any((student) => student.code == code);
                                 if(!isStudentExists){
                                   studentsProvider.get_students.add(StudentModel(name: name, code: code, phone: phone, lectures: [], exams: []));
                                   await studentsProvider.addStudent(name: name, code: code, phone: phone);
                                   context.mounted ? showBtmAlert(context,'تم الإضافة بنجاح',600):null;
                                   form.reset();
                                   codeController.clear();
                                   nameController.clear();
                                   phoneController.clear();
                                 }else{
                                   context.mounted ? showBtmAlert(context,'الطالب موجود بالفعل',600):null;
                                 }
                               } on Exception catch (e) {
                                 context.mounted ? showBtmAlert(context,'حدث خطأ ما يرجي المحاولة مرة أخري',600):null;
                               }finally{
                                 setState(() {
                                   isLoading = false;
                                 });
                               }
                              }
                          }, child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('حفظ',style: TextStyle(color: Colors.white),),
                      )),
                      SizedBox(width:width*0.1 ,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                          ),
                          onPressed: (){
                            codeController.clear();
                            nameController.clear();
                            phoneController.clear();
                      }, child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('تجاهل',style: TextStyle(color: Colors.white)),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future <void>scanQr()async{
    try{
      FlutterBarcodeScanner.scanBarcode('#E86A33', 'cancel', false, ScanMode.QR).then((value){
        if(value.length > 3){
          codeController.text = value.toString();
          code = value.toString();
        }

        setState(() {
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
