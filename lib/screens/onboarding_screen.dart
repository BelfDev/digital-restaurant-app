import 'package:dr_app/components/buttons/outline_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/screens/login_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// The OnboardingScreen contains a set of slides
/// showcasing what the App has to offer.
class OnboardingScreen extends StatefulWidget {
  static const id = "onboarding_screen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LUTheme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[
            Expanded(flex: 3, child: buildSlider()),
            Expanded(flex: 1, child: buildButtons())
          ],
        ));
  }

  Widget buildSlider() {
    final List<Slide> slides = <Slide>[
      Slide(
        text: 'Find the perfect restaurant for your taste',
        imgSrc: Images.introSlide1,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0)),
      ),
      Slide(
        text: 'Place your orders from within the app',
        imgSrc: Images.introSlide2,
      ),
      Slide(
        text: 'Pay and leave whenever you please',
        imgSrc: Images.introSlide3,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.0)),
      ),
    ];

    return Stack(
      children: <Widget>[
        IntroSlider(
          slides: slides,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                decoration: BoxDecoration(
                    color: LUColors.darkYellow.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Image.asset(
                  Images.appLogo,
                  width: 227,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtons() => SafeArea(
        top: false,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LUSolidButton(
                title: "Login",
                onPressed: () =>
                    Navigator.of(context).pushNamed(LoginScreen.id),
              ),
              SizedBox(
                height: 16,
              ),
              LUOutlineButton(
                title: "Skip",
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RootContainer()),
                    (_) => false),
              )
            ],
          ),
        ),
      );
}

class IntroSlider extends StatelessWidget {
  final List<Slide> slides;

  const IntroSlider({Key key, @required this.slides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return slides[index];
      },
      indicatorLayout: PageIndicatorLayout.SCALE,
      loop: false,
      autoplay: false,
      itemCount: slides.length,
      outer: true,
      index: 0,
      pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 16),
          builder: DotSwiperPaginationBuilder(
              space: 8.0,
              color: LUTheme.of(context).unselectedWidgetColor,
              activeColor: LUTheme.of(context).primaryColor)),
    );
  }
}

class Slide extends StatelessWidget {
  final String text;
  final String imgSrc;
  final BorderRadiusGeometry borderRadius;

  const Slide({
    Key key,
    @required this.text,
    @required this.imgSrc,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: LUColors.yellow, borderRadius: borderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 100),
            Image.asset(
              imgSrc,
              fit: BoxFit.cover,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Styles.introText,
            ),
          ],
        ),
      ),
    );
  }
}
