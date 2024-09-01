import "package:eduasses360/utils/routes/routing.dart";
import "package:eduasses360/view_model/loginPage_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";
import "/utils/routes/route_name.dart";
import "/view_model/homepage_viewmodel.dart";

void main() async {
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
                backgroundColor: Colors.grey,
                centerTitle: true,
                elevation: 8.0,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 25.sp)

              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(fontSize:18.sp, fontWeight: FontWeight.bold),
                bodyMedium: TextStyle(fontSize: 14.sp),
                bodySmall: TextStyle(fontSize:12.sp),
                titleLarge: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold,color: Colors.red,),
                titleMedium: TextStyle(fontSize: 16.sp),
                labelLarge: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.red),
              //  button: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.red),


              )
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteName.login,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        }
      ),
    );
  }
}

