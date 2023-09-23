import 'package:flutter/material.dart';
import 'package:projectsem4/view/bottomnavi/screen.dart';
import 'package:projectsem4/view/home/screen.dart';
import 'package:projectsem4/view/login.dart';
import 'package:projectsem4/view/home/screen.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:projectsem4/constraint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Montserrat-Regular",
        ),
        home: _intoductionslide(context));
        // home: BottomNavigationBarApp());
  }

  IntroductionSlider _intoductionslide(BuildContext context) {
    return IntroductionSlider(
        showStatusBar: true,
        items: [
          IntroductionSliderItem(
            backgroundImageDecoration: const BackgroundImageDecoration(
                image: AssetImage("assets/image/intro-flight-3.png"),
                fit: BoxFit.fitWidth),
            title: _slider(
                context,
                "Hey there, Welcome to VPN Travel! My name is OpenBot. Is there anything I can help you with?",
                "Welcome to VPN Travel !"),
            backgroundColor: AppConstraint.mainColor,
          ),
          IntroductionSliderItem(
            backgroundImageDecoration: const BackgroundImageDecoration(
                image: AssetImage("assets/image/intro-flight-1.png"),
                fit: BoxFit.fitWidth),
            title: _slider(
                context,
                "We are proud that we are a business that brings customers the most value in life",
                "Why VPN?"),
            backgroundColor: AppConstraint.mainColor,
          ),
          IntroductionSliderItem(
            backgroundImageDecoration: const BackgroundImageDecoration(
                image: AssetImage("assets/image/intro-flight-2.png"),
                fit: BoxFit.fitWidth),
            title: _slider(
                context,
                "VPN Team always ready bring to you the best services and moment",
                "Enjoy your trip !"),
            backgroundColor: AppConstraint.mainColor,
          ),
        ],
        done: const Done(
          child: Icon(Icons.done, color: AppConstraint.colorInput),
          home: Scaffold(body: Login()),
        ),
        next: const Next(
            child:
                Icon(Icons.arrow_forward, color: AppConstraint.colorInput)),
        back: const Back(
            child: Icon(Icons.arrow_back, color: AppConstraint.colorInput)),
        dotIndicator: const DotIndicator(
            size: 7, selectedColor: AppConstraint.colorInput),
      );
  }

  SizedBox _slider(BuildContext context, String title, String subTitle) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Container(
            margin: const EdgeInsets.only(bottom: 160),
            alignment: Alignment.bottomCenter,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Text(title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: AppConstraint.fontFamilyRegular,
                                  color: AppConstraint.colorInput,
                                  fontSize: 18)),
                          const SizedBox(height: 10),
                          Text(subTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: AppConstraint.fontFamilyBold,
                                  color: AppConstraint.colorInput,
                                  fontSize: 28)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
