import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'colo_extension.dart';

class OnBoardingPage extends StatelessWidget {
  final Map p0bj;
  const OnBoardingPage({super.key, required this.p0bj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SizedBox(
      width: media.width,
      height: media.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(
            //   p0bj["lottie"].toString(),
            //   width: media.width,
            //   fit: BoxFit.fitWidth,
            // ),
            Lottie.asset(
              p0bj["lottie"].toString(),
              width: media.width,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: media.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                p0bj["title"].toString(),
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                p0bj["subTitle"].toString(),
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
