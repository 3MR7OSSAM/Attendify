import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:student_attendance/Vews/SplashView/SplashView.dart';

class NetworkError extends StatefulWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  State<NetworkError> createState() => _NetworkErrorState();
}

class _NetworkErrorState extends State<NetworkError> {
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
                      'هناك مشكلة في إتصالك بالإنترنت اسحب الشاشة لأعلي للمحاولة مرة أخري',
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
    final result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      context.mounted
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SplashViewPage()))
          : null;
    }
  }
}
