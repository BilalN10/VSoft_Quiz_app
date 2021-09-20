import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Views/Screens/SplashScreen/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Bindings/authBinding.dart';
import 'Views/Screens/UserScreens/UserHomeScreen/userHomeScreen.dart';
import 'Views/SizeConfig/sizeConfig.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  // @override
  // initState() {
  //   super.initState();
  //   this.initDynamicLinks();
  // }

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //     final Uri deepLink = dynamicLink?.link;
  //     print("deeplink found");
  //     if (deepLink != null) {
  //       print(deepLink);
  //       Get.to(() => UserScreenLogin());
  //     }
  //   }, onError: (OnLinkErrorException e) async {
  //     print("deeplink error");
  //     print(e.message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    box.write("isQuiz", true);

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return GetMaterialApp(
            initialBinding: Authbindings(),
            title: 'Quiz app',
            theme: ThemeData(
                unselectedWidgetColor: Colors.blue, primarySwatch: Colors.blue),
//
            debugShowCheckedModeBanner: false,
            //home: UserHomeScreen());
            //  home: SearchScreen());
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) =>
                  SplashScreen(), // Default home route
              '/hellow': (BuildContext context) => UserHomeScreen(),
            });
        // routes: <String, WidgetBuilder>{
        //   "/helloworld": (BuildContext context) => UserHomeScreen(),
        //   "/": (BuildContext context) => SplashScreen(),
        // });
      });
    });
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   initState() {
//     super.initState();
//     initDynamicLinks();
//     print("InitState CAll");
//   }

//   Uri deepLink;

//   void initDynamicLinks() async {
//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData dynamicLink) async {
//       deepLink = dynamicLink?.link;
//       print("deeplink found");
//       Get.to(() => UserScreenLogin());
//       // if (deepLink != null) {
//       //   print(deepLink);
//       //   Get.to(() => UserScreenLogin());
//       // }
//     }, onError: (OnLinkErrorException e) async {
//       print("deeplink error");
//       print(e.message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return OrientationBuilder(
//           builder: (context, orientation) {
//             SizeConfig().init(constraints, orientation);

//             return GetMaterialApp(
//                 initialBinding: Authbindings(),
//                 theme: ThemeData(
//                     unselectedWidgetColor: Colors.blue,
//                     primarySwatch: Colors.blue),
//                 debugShowCheckedModeBanner: false,
//                 // home: SplashScreen(),

//                 // locale: DevicePreview.locale(context), // Add the locale here
//                 // builder: DevicePreview.appBuilder, // Add the builder here
//                 //home: MainFile(),
//                 routes: <String, WidgetBuilder>{
//                   "/helloworld": (BuildContext context) => UserHomeScreen(),
//                   "/": (BuildContext context) => SplashScreen(),
//                 }

//                 // home: MyHomePage(

//                 //   title: "SVs",

//                 // ),

//                 //  home: AdminHome(),
//                 );
//           },
//         );
//       },
//     );
//   }
// }
