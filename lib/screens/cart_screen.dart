import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/bottom_sheet_container.dart';
import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/product_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/counter.dart';
import 'package:dr_app/components/empty_content_placeholder.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/screens/payment_screen.dart';
import 'package:dr_app/utils/dialogs.dart';
import 'package:dr_app/utils/formatter.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static const id = 'cart_screen';

  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<State<CartScreen>> _keyLoader =
      new GlobalKey<State<CartScreen>>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text(
      "Active Tab",
      style: Styles.segmentControlText,
    ),
    1: Text(
      "Order Summary",
      style: Styles.segmentControlText,
    )
  };

  // ignore: close_sinks
  CartBloc cartBloc;
  CheckOutBloc checkoutBloc;

  List<Product> items;

  int segmentedControlGroupValue = 0;

  void onOrderPressed(Cart cart) {
    checkoutBloc.add(AddCartToOrderRequested(cart.id));
  }

  @override
  void initState() {
    super.initState();
    segmentedControlGroupValue = 0;

    cartBloc = BlocProvider.of<CartBloc>(context);
    checkoutBloc = BlocProvider.of<CheckOutBloc>(context);

    if (cartBloc.state.cart != null) {
      cartBloc.add(CartRequested());
      items = cartBloc.state.cart.items;
    }
  }

  void onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  void onEditCartItem(int productId, int quantity) {
    if (quantity == 0) {
      cartBloc.add(RemoveCartItemRequested(productId));
    } else {
      cartBloc.add(AddToCartRequested(productId, quantity));
    }
    Dialogs.showLoadingDialog(context, _keyLoader);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  LUCompactHeader(
                      imgSrc:
                          'https://barn2.co.uk/wp-content/uploads/2019/10/574657_FeaturedImage_ShoppingCart_Op2_103119-1.jpg',
                      icon: Icons.close,
                      onTopButtonPressed: onBackButtonPressed),
                  buildContent(),
                ],
              )
            ],
          ),
          buildFooter()
        ],
      ),
    );
  }

  Widget buildFooter() {
    final isActiveTab = segmentedControlGroupValue == 0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: isActiveTab
          ? BlocConsumer<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ContentStateStatus.loadSuccess &&
                    _keyLoader != null) {
                  // TODO: Fix nav exception
                  Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                      .pop();
                }
              },
              builder: (context, state) {
                final cart = state.cart;

                if (cart?.items == null || cart.items.isEmpty)
                  return Container();

                final totalValue = cart.subtotal ?? 0;

                return buildBottomSliver(
                  totalValue,
                  () {
                    setState(
                      () {
                        segmentedControlGroupValue = 1;
                        onOrderPressed(cart);
                      },
                    );
                  },
                );
              },
            )
          : BlocBuilder<CheckOutBloc, CheckOutState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                final order = state.order;

                if (order == null) return Container();

                final totalValue = order?.subtotal ?? 0;

                return buildBottomSliver(totalValue, () {
                  setState(
                    () {
                      activateBottomSheet(context);
                    },
                  );
                });
              },
            ),
    );
  }

  Widget buildBottomSliver(double totalValue, VoidCallback onButtonPressed) {
    return LUBottomSliver(
      buttonTitle: segmentedControlGroupValue == 0 ? 'order' : 'check-out',
      subtotal: totalValue,
      buttonType: segmentedControlGroupValue == 0
          ? BottomSliverButton.SOLID
          : BottomSliverButton.SLIDER,
      onButtonPressed: onButtonPressed,
    );
  }

  Widget buildContent() {
    return RoundContainer(
      child: Column(
        children: <Widget>[
          CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: segmentTabs,
              onValueChanged: (i) {
                setState(() {
                  segmentedControlGroupValue = i;
                });
              }),
          segmentedControlGroupValue == 0
              ? getActiveTabList()
              : getOrderSummaryList(),
        ],
      ),
    );
  }

  Widget getActiveTabList() {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        if (state.cart == null) {
          return LUEmptyContentPlaceholder(
            height: 400,
            message: 'Please check-in a restaurant first',
          );
        }

        return LULoadableContent(
            height: 400,
            stateStatus: state.status,
            contentBuilder: () {
              final items = state.cart.items;

              if (state.status == ContentStateStatus.loadSuccess &&
                  (items == null || items.isEmpty)) {
                return LUEmptyContentPlaceholder(
                  height: 400,
                  message: 'Your tab is empty',
                );
              }

              return getCartItemList(items);
            });
      },
    );
  }

  Widget getOrderSummaryList() {
    return BlocConsumer<CheckOutBloc, CheckOutState>(
      listener: (BuildContext context, CheckOutState state) {},
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (BuildContext context, CheckOutState state) {
        final orderCartItems = state.items;

        if (state.status != ContentStateStatus.loadInProgress &&
            orderCartItems == null) {
          return LUEmptyContentPlaceholder(
            height: 400,
            message: 'Place orders first',
          );
        }

        return LULoadableContent(
            height: 400,
            stateStatus: state.status,
            contentBuilder: () {
              if (state.status == ContentStateStatus.loadSuccess &&
                  orderCartItems.isEmpty) {
                return LUEmptyContentPlaceholder(
                  height: 400,
                  message: 'Your tab is empty',
                );
              }

              return getCartItemList(orderCartItems);
            });
      },
    );
  }

  Widget getCartItemList(List<Product> items) {
    return LUList(
      padding: EdgeInsets.only(top: 24, bottom: 200),
      nested: true,
      space: 10,
      items: List.generate(
        items.length,
        (index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: LUProductCard(
                    margin: (segmentedControlGroupValue == 0)
                        ? EdgeInsets.only(right: 8.0)
                        : EdgeInsets.zero,
                    shrink: segmentedControlGroupValue == 0,
                    showStatus: segmentedControlGroupValue != 0,
                    imageSrc: item?.images?.first?.source ?? '',
                    title: item.title,
                    description: item.description,
                    priceTag: Formatter.convertToMoney(item.unitPrice),
                    preparationTime: item.preparationTime,
                    quantity: item.quantity,
                  ),
                ),
                if (segmentedControlGroupValue == 0)
                  LUCounter(
                      initialValue: item.quantity,
                      minValue: 0,
                      vertical: true,
                      onUpdate: (quantity) =>
                          onEditCartItem(item.id, quantity)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getItemList() => BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (_, state) {
          if (state.cart == null) {
            return LUEmptyContentPlaceholder(
              height: 400,
              message: 'Please check-in a restaurant first',
            );
          }

          return LULoadableContent(
              height: 400,
              stateStatus: state.status,
              contentBuilder: () {
                final items = state.cart.items;

                if (state.status == ContentStateStatus.loadSuccess &&
                    items.isEmpty) {
                  return LUEmptyContentPlaceholder(
                    height: 400,
                    message: 'Your tab is empty',
                  );
                }

                return LUList(
                  padding: EdgeInsets.only(top: 24, bottom: 56),
                  nested: true,
                  space: 10,
                  items: List.generate(
                    items.length,
                    (index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: LUProductCard(
                                margin: (segmentedControlGroupValue == 0)
                                    ? EdgeInsets.only(right: 8.0)
                                    : EdgeInsets.zero,
                                shrink: segmentedControlGroupValue == 0,
                                showStatus: segmentedControlGroupValue != 0,
                                imageSrc: item?.images?.first?.source ?? '',
                                title: item.title,
                                description: item.description,
                                priceTag:
                                    Formatter.convertToMoney(item.unitPrice),
                                preparationTime: item.preparationTime,
                                quantity: item.quantity,
                              ),
                            ),
                            if (segmentedControlGroupValue == 0)
                              LUCounter(
                                  initialValue: item.quantity,
                                  minValue: 0,
                                  vertical: true,
                                  onUpdate: (quantity) =>
                                      onEditCartItem(item.id, quantity)),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        },
      );

  void activateBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(LUTheme.bottomSheetRadius),
                topLeft: Radius.circular(LUTheme.bottomSheetRadius))),
        builder: (ctx) {
          return LUBottomSheetContainer(
            title: 'Choose payment method',
            children: <Widget>[
              LUSolidButton(
                title: 'Pay with Pay',
                uppercase: false,
                color: Colors.black,
                // onPressed: () {},
              ),
              LUSolidButton(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  title: 'Pay with credit card',
                  uppercase: false,
                  color: LUTheme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(PaymentScreen.id);
                  }),
            ],
          );
        });
  }
}
