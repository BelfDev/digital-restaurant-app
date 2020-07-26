import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const List<String> images = [
  'https://picsum.photos/200/400',
  'https://picsum.photos/200/500',
  'https://picsum.photos/200/200'
];

class LUSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          images[index],
          fit: BoxFit.fill,
        );
      },
      indicatorLayout: PageIndicatorLayout.SCALE,
      autoplay: false,
      itemCount: images.length,
      pagination: SwiperPagination(),
    );
  }
}
