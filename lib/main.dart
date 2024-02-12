import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Services/Providers/AttendanceProvider.dart';
import 'Services/Providers/StudentProvider.dart';
import 'Vews/SplashView/SplashView.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();


  runApp(const MyApp());
}
final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _firebaseInitialization,
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Scaffold(
            body: Center(child: CircularProgressIndicator(),),),);
        } else if (snapshot.hasError) {
          return const MaterialApp(home: Scaffold(
            body: Center(child: Text('There is an error'),),),);
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_){
              return StudentProvider();
            }),  ChangeNotifierProvider(create: (_){
              return AttendanceProvider();
            }),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.black54,
                  selectionColor: Colors.black54,
                  selectionHandleColor: Colors.black54,
                ),
                fontFamily: 'Khebrat Regular'
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar','AE'), // Arabic
            ],
            title: 'Student Attendance',
            home: const SplashViewPage(),
          ),
        );
      },
    );
  }
}

