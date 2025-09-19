import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/ui/hadeth/hadeth_item.dart';
class HadethScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 618.h,
        scrollDirection: Axis.horizontal,
        enableInfiniteScroll: true,
        enlargeCenterPage: true
      ),
      items:  List.generate(50, (index) => index + 1).map((i) {
          return HadethItem(
            index: i,
          );
        }).toList(),
    );
  }
}

