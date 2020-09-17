import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/tip_toolbar.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/tip.dart';
import 'package:dr_app/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The Payment screen is the last step of the check-out flow.
/// Here the user is able to select which card he/she wants to
/// use for payment as well as the desired tip amount.
class PaymentScreen extends StatefulWidget {
  static const id = 'payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const _CITY_REGION = 'Glasgow';
  final GlobalKey<State<PaymentScreen>> _keyLoader =
      GlobalKey<State<PaymentScreen>>();

  HomeBloc homeBloc;
  CheckOutBloc checkOutBloc;

  double tipIncluded;

  void onPayPressed() {
    final order = checkOutBloc.state.order;
    this.checkOutBloc.add(MakePaymentRequested(order.id, 1));
    Dialogs.showLoadingDialog(context, _keyLoader);
  }

  @override
  void initState() {
    super.initState();
    tipIncluded = 0.0;
    checkOutBloc = BlocProvider.of<CheckOutBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: CreditCardSlider(
              dummyCreditCards,
              initialCard: 0,
              repeatCards: RepeatCards.bothDirection,
              percentOfUpperCard: 0.8,
              onCardClicked: (index) {
                print('Clicked at index: $index');
              },
            ),
          ),
          SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                color: LUTheme.of(context).backgroundColor),
          ),
          Column(
            children: <Widget>[
              LUTopBar(
                title: 'Payment',
                buttonBackgroundColor: LUTheme.of(context).primaryColor,
                tint: LUTheme.of(context).backgroundColor,
                onNavigationButtonPressed: () => Navigator.of(context).pop(),
              ),
              LUSection(
                title: 'Tip the service',
                margin: EdgeInsets.only(top: 32.0),
                builder: (_) => LUTipToolbar(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  tipOptions: [
                    Tip('😢', 0.0),
                    Tip('10%', 0.10),
                    Tip('15%', 0.15),
                    Tip('20%', 0.20),
                  ],
                  onPressed: (tip) {
                    print(tip.displayText);
                    setState(() {
                      tipIncluded = tip.value;
                    });
                  },
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<CheckOutBloc, CheckOutState>(
                listener: (context, state) {
                  if (state.status == ContentStateStatus.loadSuccess) {
                    homeBloc
                      ..add(CheckOutRequested())
                      ..add(FeaturedOutletsRequested(city: _CITY_REGION))
                      ..add(CuisinesRequested())
                      ..add(NearbyOutletsRequested(city: _CITY_REGION));

                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                builder: (context, state) {
                  final order = state.order;
                  return LUBottomSliver(
                    buttonTitle: 'pay',
                    tip: tipIncluded,
                    subtotal: order.subtotal ?? 0.0,
                    onButtonPressed: onPayPressed,
                  );
                },
              )),
        ],
      ),
    );
  }
}
