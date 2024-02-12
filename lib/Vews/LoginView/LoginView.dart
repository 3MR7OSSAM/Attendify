import 'package:flutter/material.dart';

import '../Widgets/CustomAppBar.dart';
import '../Widgets/customFormField.dart';
class LoginViewPage extends StatefulWidget {
   const LoginViewPage({Key? key}) : super(key: key);

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  late  TextEditingController userController ;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController= TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(isMain: true, title: ' تسجيل الدخول ',),
                Image.asset('assets/images/login_image.png',width: 250,),
                const Text('مرحبا بعودتك !',style: TextStyle(color: Colors.black54,fontSize: 28),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(controller: userController, onChanged: (userName) {  }, hintText: 'إسم المستخدم ', obscureText: false, isNumber: false,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(controller: passwordController, onChanged: (password) {

                  }, hintText: 'كلمة المرور', obscureText: true, isNumber: false,),
                ),
                SizedBox(height: height*0.01,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.black54, // Text Color (Foreground color)
                    ),
                    onPressed: (){

                    }, child: const Text('تسجيل الدخول',style: TextStyle(
                  color: Colors.white
                ),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
