import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance/Services/Providers/StudentProvider.dart';
import 'package:student_attendance/Vews/SplashView/SplashView.dart';

import '../HomeView/HomeView.dart';

class DataError extends StatefulWidget {
  const DataError({Key? key}) : super(key: key);

  @override
  State<DataError> createState() => _DataErrorState();
}

class _DataErrorState extends State<DataError> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
          onRefresh: () async {
            checkConnection();
          },
          child: Scaffold(
            body: ListView(
              children: [
                Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .6,
                      child: Padding(
                        padding:  EdgeInsets.only(top : MediaQuery.sizeOf(context).height*.45),
                        child: const Text(
                          textAlign: TextAlign.center,
                          'حدثت مشكلة أثناء جلب البينات إسحب الشاشة للمحاولة مرة أخري',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  void checkConnection() async {
   context.mounted ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SplashViewPage())):null;
  }
}
