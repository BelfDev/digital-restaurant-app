import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LUSwiper extends StatelessWidget {
  final List<String> imgSrcList;

  const LUSwiper({Key key, this.imgSrcList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: LUColors.smoothGray,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: FadeInImage.assetNetwork(
              placeholder: Images.horizontalPlaceholder,
              image: imgSrcList[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      indicatorLayout: PageIndicatorLayout.SCALE,
      autoplay: false,
      itemCount: imgSrcList.length,
      outer: true,
      pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 16),
          builder: DotSwiperPaginationBuilder(
              space: 8.0,
              color: LUTheme.of(context).unselectedWidgetColor,
              activeColor: LUTheme.of(context).primaryColor)),
    );
  }
}
