import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../component/colo_extension.dart';
import '../component/on_boarding_page.dart';
import 'Authpage.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;

      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Detect your Pose",
      "subTitle":
          "We track your posture when you train to determine if it is correct or not, and provide numerical feedback on how often you maintained the correct posture.",
      "lottie": "assets/lottie/kick.json",
    },
    {
      "title": "Tracking the Ball",
      "subTitle":
          "We assess whether the ball flies correctly when you kick it and provide numerical feedback on how often it flew in the right direction during training.",
      "lottie": "assets/lottie/ball.json",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var p0bj = pageArr[index] as Map? ?? {};
                return OnBoardingPage(p0bj: p0bj);
              }),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: (selectPage + 1) / 2,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColor.white,
                    ),
                    color: TColor.primaryColor1,
                    onPressed: () {
                      if (selectPage < 1) {
                        //open welcome screen
                        selectPage = selectPage + 1;
                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.bounceInOut);
                        controller.jumpToPage(selectPage);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthPage(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:final_jiyun/component/loginBtn.dart';
// import 'package:final_jiyun/component/colo_extension.dart';
// import 'package:final_jiyun/component/on_boarding_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:lottie/lottie.dart';

// class OnBoardingView extends StatefulWidget {
//   const OnBoardingView({super.key});

//   @override
//   State<OnBoardingView> createState() => _OnBoardingViewState();
// }

// class _OnBoardingViewState extends State<OnBoardingView> {
//   int selectPage = 0;
//   PageController controller = PageController();

//   @override
//   void initState() {
//     super.initState();

//     controller.addListener(() {
//       setState(() {
//         selectPage = controller.page?.round() ?? 0;
//       });
//     });
//   }

//   List<Map<String, String>> pageArr = [
//     {
//       "title": "Detect your Pose",
//       "subTitle":
//           "We track your posture when you train to determine if it is correct or not, and provide numerical feedback on how often you maintained the correct posture.",
//       "lottie": "assets/lottie/kick.json",
//     },
//     {
//       "title": "Tracking the Ball",
//       "subTitle":
//           "We assess whether the ball flies correctly when you kick it and provide numerical feedback on how often it flew in the right direction during training.",
//       "lottie": "assets/lottie/ball.json",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: TColor.white,
//       body: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           PageView.builder(
//             controller: controller,
//             itemCount: pageArr.length,
//             itemBuilder: (context, index) {
//               var p0bj = pageArr[index] as Map? ?? {};
//               return OnBoardingPage(p0bj: p0bj);
//             },
//           ),
//           if (selectPage < pageArr.length - 1) buildNextButton(),
//           if (selectPage == pageArr.length - 1) const GoogleSignInButton(),
//         ],
//       ),
//     );
//   }

//   Widget buildNextButton() {
//     return SizedBox(
//       width: 120,
//       height: 120,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           SizedBox(
//             width: 70,
//             height: 70,
//             child: CircularProgressIndicator(
//               color: TColor.primaryColor1,
//               value: (selectPage + 1) / 2,
//               strokeWidth: 2,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(
//               horizontal: 30,
//               vertical: 30,
//             ),
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: TColor.primaryColor1,
//               borderRadius: BorderRadius.circular(35),
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.navigate_next,
//                 color: TColor.white,
//               ),
//               color: TColor.primaryColor1,
//               onPressed: () {
//                 if (selectPage < pageArr.length - 1) {
//                   selectPage = selectPage + 1;
//                   controller.animateToPage(
//                     selectPage,
//                     duration: const Duration(milliseconds: 1200),
//                     curve: Curves.bounceInOut,
//                   );
//                   controller.jumpToPage(selectPage);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
