import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Bindings/root.dart';
import 'package:quizapp/Bindings/rootForAdmin.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminLoginScreen/adminLoginScreen.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/check.dart';
import 'package:quizapp/dynamicLinks/mainFile.dart';

import 'Components/UserTypeContainer.dart';

class AdminUserSelectionPage extends StatefulWidget {
  const AdminUserSelectionPage({Key key}) : super(key: key);

  @override
  _AdminUserSelectionPageState createState() => _AdminUserSelectionPageState();
}

class _AdminUserSelectionPageState extends State<AdminUserSelectionPage> {
  //final box = GetStorage();
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());
  // @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  //Uri deepLink;
  int adminIDindex;
  final box = GetStorage();

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    userQuestionController.deepLink = data?.link?.obs;

    if (userQuestionController.deepLink != null) {
      //  print("Deep Link is admin user $userQuestionControllerdeepLink");
      userController.user.uid != null && box.read("isStudent")
          ? Get.to(() => Root())
          : Get.to(() => UserScreenLogin());

      // userQuestionController.quizIdFromUrl =
      //     deepLink.toString().split("?").last.obs;
      // adminIDindex = deepLink.toString().split("?").length - 1;
      // userQuestionController.adminIdFromUrl =
      //     deepLink.toString().split("?")[adminIDindex - 1].obs;

      // userQuestionController.getUserId();
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      userQuestionController.deepLink = dynamicLink?.link?.obs;
      print("Link is adminUserSelection ${userQuestionController.deepLink}");
      //userQuestionController.adminID = deepLink.toString().obs;

      if (userQuestionController.deepLink != null) {
        userController.user.uid != null && box.read("isStudent")
            ? Get.to(() => Root())
            : Get.to(() => UserScreenLogin());

        // userQuestionController.quizIdFromUrl =
        //     deepLink.toString().split("?").last.obs;
        // adminIDindex = deepLink.toString().split("?").length - 1;
        // userQuestionController.adminIdFromUrl =
        //     deepLink.toString().split("?")[adminIDindex - 1].obs;

        // userQuestionController.getUserId();

      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CommonBackground(
            childd: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    "Select User Type",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 04 * SizeConfig.textMultiplier,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 05 * SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserTypeContainer(
                            image: "assets/Images/admin.png",
                            title: "Admin",
                            nextPage: () {
                              //Get.to(() => MainFile());
                              Get.to(() => AdminRoot());
                            }),
                        UserTypeContainer(
                            image: "assets/Images/user.png",
                            title: "User",
                            nextPage: () {
                              Get.to(() => Root());
                              //Get.to(() => Check() );
                              // Get.to(UserScreenLogin());
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
