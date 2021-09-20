import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class GetQuizLink extends StatefulWidget {
  GetQuizLink({this.questionList});
  final List<QuizQuestionModel> questionList;

  @override
  _GetQuizLinkState createState() => _GetQuizLinkState();
}

class _GetQuizLinkState extends State<GetQuizLink> {
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());
  bool showLinkButton = false;
  List<String> txt = [
    "Teacher ID : HwjT4JBldFMB3gjCV6abZIPlrJv1 ",
    "Quiz ID : TCnkmfbZ6dRuEv0sNX2k"
  ];
  Uri check;
  String text = 'https://medium.com/@suryadevsingh24032000';
  String subject = 'follow me';
  bool _iscreateLink = false;
  bool shareLink = false;
  String _linkMessage;
  String _textMessage =
      "to long press the link and copy then click to the link ";
  // final UserQuestionController userQuestionController =
  //     Get.put(UserQuestionController());
  @override
  void initState() {
    initialCheck();
    userQuestionController.quizNameController.text = "";
    userQuestionController.isQuizAssign = false.obs;
    super.initState();
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _iscreateLink = true;
    });
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: "https://learndy.page.link",
        link: Uri.parse(
            "https://learndy.page.link/hellow?${userController.user.uid}?${userQuestionController.quizID}"),
        androidParameters: AndroidParameters(
          packageName: "com.vsoft.quizapp",
          minimumVersion: 0,
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
            shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "Virtual Soft Quiz App", description: "Best of luck"));

    Uri url;
    if (short) {
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      url = shortDynamicLink.shortUrl;
      check = shortDynamicLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
      check = await parameters.buildUrl();
    }
    setState(() {
      _linkMessage = url.toString();
      txt.add(_linkMessage);
      _iscreateLink = false;
    });
  }

  Future<void> initialCheck() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      print("Dynamic Link on Mainfile is ${dynamicLink?.link?.path}");
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        //  Navigator.pushNamed(context, deepLink.path);
        print("deeplink is $deepLink");
      }
    }, onError: (OnLinkErrorException e) async {
      print("OnlinkError");
      print(e.toString());
    });
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print("deeplink is $deepLink");
      // Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        childd: Column(
          children: [
            SizedBox(
              height: 25 * SizeConfig.heightMultiplier,
            ),
            CommonFlateButton(
              height: 8 * SizeConfig.heightMultiplier,
              width: 50 * SizeConfig.widthMultiplier,
              title: "Generate Quiz",
              pressed: () {
                if (userQuestionController.quizNameController == null ||
                    userQuestionController.quizNameController.text.isEmpty) {
                  Get.defaultDialog(
                      title: "",
                      middleText: "Please Enter quiz name",
                      middleTextStyle: TextStyle(
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                      confirm: CommonFlateButton(
                        height: 5 * SizeConfig.heightMultiplier,
                        width: 10 * SizeConfig.widthMultiplier,
                        title: "Add",
                        pressed: () {
                          print(userQuestionController.quizNameController);
                          // setState(() {
                          //   check = !check;
                          // });
                          Get.back();
                        },
                      ),
                      actions: [quizNameDialog()]);
                } else {
                  userQuestionController.addQuestionToUser(
                      widget.questionList, userController.user.uid);
                }
                setState(() {
                  showLinkButton = true;
                });
              },
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            GetX<UserQuestionController>(
              init: Get.put<UserQuestionController>(UserQuestionController()),
              builder: (UserQuestionController userQuestionController) {
                return userQuestionController.isQuizAssign.value
                    ? Column(
                        children: [
                          CommonFlateButton(
                            height: 8 * SizeConfig.heightMultiplier,
                            width: 50 * SizeConfig.widthMultiplier,
                            title: "Get Link",
                            pressed: !_iscreateLink
                                ? () => _createDynamicLink(true)
                                : null,
                          ),
                          SizedBox(
                            height: 10 * SizeConfig.heightMultiplier,
                          ),
                          _linkMessage != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        _linkMessage ?? "",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize:
                                                2 * SizeConfig.textMultiplier),
                                      ),
                                      onTap: () async {
                                        if (_linkMessage != null) {
                                          await launch(_linkMessage);
                                        }
                                      },
                                      onLongPress: () {
                                        Clipboard.setData(
                                            ClipboardData(text: _linkMessage));
                                      },
                                    ),
                                    SizedBox(
                                      width: 2 * SizeConfig.widthMultiplier,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        widget.questionList.length = 0;
                                        userQuestionController
                                            .quizNameController.text = "";
                                        final RenderBox box =
                                            context.findRenderObject();
                                        Share.share(_linkMessage,
                                            subject: subject,
                                            sharePositionOrigin:
                                                box.localToGlobal(Offset.zero) &
                                                    box.size);
                                      },
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: primarycolor,
                                        size:
                                            6 * SizeConfig.imageSizeMultiplier,
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),

                          //  Text(_linkMessage == null ? "" : _textMessage),
                        ],
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget quizNameDialog() {
    return Column(
      children: [
        SingleChildScrollView(
          child: CommonTextField(
            controller: userQuestionController.quizNameController,
            hintText: "Quiz Name",
            title: "Enter Quiz",
          ),
        ),
      ],
    );
  }
}
