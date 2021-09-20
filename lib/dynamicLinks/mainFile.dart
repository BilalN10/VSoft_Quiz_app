// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:quizapp/Controllers/userQuestionController.dart';
// import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
// import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MainFile extends StatefulWidget {
//   @override
//   _MainFileState createState() => _MainFileState();
// }

// class _MainFileState extends State<MainFile> {
//   List<String> txt = [
//     "Teacher ID : HwjT4JBldFMB3gjCV6abZIPlrJv1 ",
//     "Quiz ID : TCnkmfbZ6dRuEv0sNX2k"
//   ];
//   Uri check;
//   String text = 'https://medium.com/@suryadevsingh24032000';
//   String subject = 'follow me';
//   bool _iscreateLink = false;
//   String _linkMessage;
//   String _textMessage =
//       "to long press the link and copy then click to the link ";
//   final UserQuestionController userQuestionController =
//       Get.put(UserQuestionController());
//   @override
//   void initState() {
//     initialCheck();
//     super.initState();
//   }

//   Future<void> _createDynamicLink(bool short) async {
//     setState(() {
//       _iscreateLink = true;
//     });
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         uriPrefix: "https://learndy.page.link",
//         link: Uri.parse(
//             "https://learndy.page.link/helloworld?${userQuestionController.adminID}?${userQuestionController.quizID}"),
//         androidParameters: AndroidParameters(
//           packageName: "com.example.quizapp",
//           minimumVersion: 0,
//         ),
//         dynamicLinkParametersOptions: DynamicLinkParametersOptions(
//             shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short),
//         socialMetaTagParameters: SocialMetaTagParameters(
//             title: "the title of the dynamic link",
//             description: "the random description of the dynamic link"));

//     Uri url;
//     if (short) {
//       final ShortDynamicLink shortDynamicLink =
//           await parameters.buildShortLink();
//       url = shortDynamicLink.shortUrl;
//       check = shortDynamicLink.shortUrl;
//     } else {
//       url = await parameters.buildUrl();
//       check = await parameters.buildUrl();
//     }
//     setState(() {
//       _linkMessage = url.toString();
//       txt.add(_linkMessage);
//       _iscreateLink = false;
//     });
//   }

//   Future<void> initialCheck() async {
//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData dynamicLink) async {
//       print("Dynamic Link on Mainfile is ${dynamicLink?.link?.path}");
//       final Uri deepLink = dynamicLink?.link;
//       if (deepLink != null) {
//         // Navigator.pushNamed(context, deepLink.path);
//       }
//     }, onError: (OnLinkErrorException e) async {
//       print("OnlinkError");
//       print(e.toString());
//     });
//     final PendingDynamicLinkData data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     final Uri deepLink = data?.link;
//     if (deepLink != null) {
//       //Navigator.pushNamed(context, deepLink.path);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               RaisedButton(
//                 onPressed:
//                     !_iscreateLink ? () => _createDynamicLink(false) : null,
//                 child: Text(
//                   "Long Link",
//                 ),
//               ),
//               RaisedButton(
//                 onPressed:
//                     !_iscreateLink ? () => _createDynamicLink(true) : null,
//                 child: Text("Short Link"),
//               ),
//               SizedBox(
//                 height: 20 * SizeConfig.heightMultiplier,
//               ),
//               InkWell(
//                 child: Text(
//                   _linkMessage ?? "",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//                 onTap: () async {
//                   if (_linkMessage != null) {
//                     await launch(_linkMessage);
//                   }
//                 },
//                 onLongPress: () {
//                   Clipboard.setData(ClipboardData(text: _linkMessage));
//                 },
//               ),
//               Text(_linkMessage == null ? "" : _textMessage),
//               SizedBox(
//                 height: 20 * SizeConfig.heightMultiplier,
//               ),
//               RaisedButton(
//                 child: Text('Share'),
//                 onPressed: () {
//                   final RenderBox box = context.findRenderObject();
//                   Share.share("${txt[0]} ${txt[1]} $_linkMessage",
//                       subject: subject,
//                       sharePositionOrigin:
//                           box.localToGlobal(Offset.zero) & box.size);
//                 },
//               ),
//               RaisedButton(
//                 child: Text('Share'),
//                 onPressed: () {
//                   print(check);
//                   // print(userQuestionController.adminID);
//                   //print(_linkMessage.split("").getRange(0, 10));
//                   //print(_linkMessage.split("/").fillRange(start, end));
//                   // final RenderBox box = context.findRenderObject();
//                   // Share.share(_linkMessage,
//                   //     subject: subject,
//                   //     sharePositionOrigin:
//                   //         box.localToGlobal(Offset.zero) & box.size);
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CheckFile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text("Dynamic Screen"),
//           ),
//           body: Center(
//             child: Text("Hello World"),
//           )),
//     );
//   }
// }
