import "package:eduasses360/utils/routes/routing.dart";
import "package:eduasses360/view_model/admin_model_test_view_model.dart";
import "package:eduasses360/view_model/loginPage_viewmodel.dart";
import "package:eduasses360/view_model/main_pages_view_model.dart";
import "package:eduasses360/view_model/model_test_view_model.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";
import "/utils/routes/route_name.dart";
import "/view_model/homepage_viewmodel.dart";
import "package:firebase_core/firebase_core.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDtgFNbnq9Y7yJld59wrMvFHyYsljHwG7A",
      appId: '1:198397395923:android:9a1f2b9146f720cdee6526',
      projectId: 'eduasses360',
      messagingSenderId:'198397395923'

    )
  );
  await ScreenUtil.ensureScreenSize();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageViewModel>(
          create: (context) => HomePageViewModel(),
        ),
        ChangeNotifierProvider<LoginPageViewModel>(
          create: (context) => LoginPageViewModel(),
        ),
        ChangeNotifierProvider<MainPagesViewModel>(
          create: (context) => MainPagesViewModel(),
        ),
        ChangeNotifierProvider<AdminModelTestViewModel>(
          create: (context) => AdminModelTestViewModel(),
        ),
        ChangeNotifierProvider<ModelTestViewModel>(
          create: (context) => ModelTestViewModel(),
        )
      ],
      child: ScreenUtilInit(

        designSize: Size(deviceWidth,deviceHeight),
        minTextAdapt: true,
          splitScreenMode: false,

        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey,
                centerTitle: true,
                elevation: 8.0,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 25.sp)

              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(fontSize:18.sp, fontWeight: FontWeight.bold),
                bodyMedium: TextStyle(fontSize: 14.sp),
                bodySmall: TextStyle(fontSize:12.sp),
                titleLarge: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold,color: Colors.black,),
                titleMedium: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.black),
                labelLarge: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.red),
              //  button: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.red),


              )
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: FirebaseAuth.instance.currentUser !=null ? RouteName.mainPage : RouteName.login,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        }
      ),
    );
  }
}

