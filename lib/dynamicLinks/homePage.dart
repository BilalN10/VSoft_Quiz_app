// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';

// class MyPages extends StatefulWidget {
//   @override
//   _MyHomepageState createState() => _MyHomepageState();
// }

// class _MyHomepageState extends State<MyPages> {
//   @override
//   void initState() {
//     super.initState();
//     print(deepLink);
//     print("hello");
//     this.initDynamicLinks();
//   }

//   Uri deepLink;

//   void initDynamicLinks() async {
//     final PendingDynamicLinkData data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     deepLink = data?.link;

//     if (deepLink != null) {
//       print("Deep Link is $deepLink");
//       //Navigator.pushNamed(context, deepLink.path);
//     }

//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData dynamicLink) async {
//       final Uri deepLink = dynamicLink?.link;

//       if (deepLink != null) {
//         // Navigator.pushNamed(context, deepLink.path);
//       }
//     }, onError: (OnLinkErrorException e) async {
//       print('onLinkError');
//       print(e.message);
//     });
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _retrieveDynamicLink();
//   // }

//   // Future<void> _retrieveDynamicLink() async {
//   //   final PendingDynamicLinkData data =
//   //       await FirebaseDynamicLinks.instance.getInitialLink();
//   //   final Uri deepLink = data?.link;

//   //   if (deepLink != null) {
//   //     Navigator.pushNamed(context, deepLink.path); // '/helloworld'
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Heelo"),
//       ),
//     );
//   }
// }
