import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/Methods/ShowBtmAlert.dart';
import '../../Services/Providers/StudentProvider.dart';
import '../HomeView/HomeView.dart';
import 'GettingDataError.dart';
import 'NetworkErrorView.dart';

class SplashViewPage extends StatefulWidget {
  const SplashViewPage({Key? key}) : super(key: key);

  @override
  State<SplashViewPage> createState() => _SplashViewPageState();
}

class _SplashViewPageState extends State<SplashViewPage> {
// Future<void> _checkInternet ()async{
//   final result = await Connectivity().checkConnectivity();
//   if(result == ConnectivityResult.none){
//     if (context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LostConnectionView()));
//   }
// }
bool hasError = false;
  @override
  void initState() {
    checkConnection();
    Future.delayed(const Duration(seconds: 2),()async{
      final studentProvider = Provider.of<StudentProvider>(context,listen: false);
      await studentProvider.getStudents(context);
      if (!studentProvider.getStatus){
        context.mounted ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeViewPage())):null;
      }else{
        context.mounted ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DataError())):null;
      }
    });
    super.initState();
  }
  void checkConnection ()async{
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none){
      context.mounted? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NetworkError())):null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // SizedBox(height: height*0.4,),
            Center(child: Text(!hasError ? 'جاري تحميل البيانات ..':'حدث خطأ ما ! ',style: const TextStyle(color: Colors.black),)),
            const SizedBox(height: 30,),
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
              ),
            ),
          ],
        ),
      ),
    );
  }
}
