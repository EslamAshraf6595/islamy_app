import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/ui/welcome_screen/intro_screen.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:islamy_app/utils/app_colors.dart';

class OnboardingScreens extends StatefulWidget {
  final int index;
  OnboardingScreens({this.index = 0});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  int selectedIndex = 0;
  late PageController _pageController =
      PageController(initialPage: selectedIndex);

  List<String> images = [
    AppAssets.intro1,
    AppAssets.intro2,
    AppAssets.intro3,
    AppAssets.intro4,
    AppAssets.intro5,
  ];

  List<String> titles = [
    "Welcome To Islami",
    "Welcome To Islami",
    "Reading the Quran",
    "Bearish",
    "Holy Quran Radio",
  ];

  List<String> contents = [
    "",
    "We Are Very Excited To Have You In Our Community",
    "Read, and your Lord is the Most Generous",
    "Praise the name of your Lord, the Most High",
    "You can listen to the Holy Quran Radio through the application for free and easily",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(AppAssets.botuniconSoura),

          // Pages
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return IntroScreen(
                  image: images[index],
                  titel: titles[index],
                  content: contents[index],
                  index: selectedIndex,
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back
                selectedIndex == 0
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(
                              color: AppColor.elevatedBg,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                SmoothPageIndicator(
                  controller: _pageController,
                  count: images.length,
                  effect: JumpingDotEffect(
                    activeDotColor: AppColor.elevatedBg,
                    dotColor: Colors.grey.shade400,
                    dotHeight: 10.w,
                    dotWidth: 10.w,
                    spacing: 8.w,
                    jumpScale: 1,
                    verticalOffset: 15,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),

                // Next
                GestureDetector(
                  onTap: () {
                    if (selectedIndex < images.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    if (selectedIndex + 1 == images.length) {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homeRoute);
                    }
                  },
                  child: Text(
                    selectedIndex == images.length - 1 ? "Done" : "Next",
                    style: TextStyle(
                        color: AppColor.elevatedBg,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
