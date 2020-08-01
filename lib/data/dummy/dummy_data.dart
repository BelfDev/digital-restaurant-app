import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:dr_app/data/models/chip_item.dart';
import 'package:dr_app/data/models/cuisine_category.dart';
import 'package:dr_app/data/models/dish.dart';
import 'package:dr_app/data/models/featured_outlet.dart';
import 'package:dr_app/data/models/outlet.dart';
import 'package:dr_app/data/models/wallet_option.dart';
import 'package:flutter/material.dart';

const dummyCards = [
  'Restaurant 1',
  'Restaurant 2',
  'Restaurant 3',
  'Restaurant 4',
  'Restaurant 5',
  'Restaurant 6',
  'Restaurant 7',
  'Restaurant 8',
  'Restaurant 9',
  'Restaurant 10'
];

const dummyOutlets = [
  Outlet('Bar Soba', 'https://picsum.photos/400/300?random=1', 3, '\$\$',
      'Asian Fusion Cuisine'),
  Outlet('Sputini', 'https://picsum.photos/200/400', 3, '\$\$',
      'Asian Fusion Cuisine'),
  Outlet('Qdoba', 'https://picsum.photos/200/500', 2, '\$\$',
      'Asian Fusion Cuisine'),
  Outlet('McDonalds', 'https://picsum.photos/200/303', 3, '\$\$',
      'Asian Fusion Cuisine'),
  Outlet('Fogo de chão', 'https://picsum.photos/200/440', 3.5, '\$\$\$',
      'Asian Fusion Cuisine'),
  Outlet('BB King Steak House', 'https://picsum.photos/200/298', 5, '\$\$\$',
      'Asian Fusion Cuisine'),
];

const dummyCuisines = [
  CuisineCategory('Italian', 'https://picsum.photos/102'),
  CuisineCategory('Brazilian', 'https://picsum.photos/108'),
  CuisineCategory('Japanese', 'https://picsum.photos/110'),
  CuisineCategory('Greek', 'https://picsum.photos/222'),
];

const dummyFeaturedOutlets = [
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1001'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1002'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1003'),
  FeaturedOutlet(
      'Bar Soba', 'Asian Fusion', 4, '\$\$', 'https://picsum.photos/1004')
];

const List<String> dummySwiperImages = [
  'https://picsum.photos/200/400',
  'https://picsum.photos/200/500',
  'https://picsum.photos/200/200'
];

const List<ChipItem> dummyChipItems = [
  ChipItem(text: 'Noodles', value: 0),
  ChipItem(text: 'Curry', value: 1),
  ChipItem(text: 'Burger', value: 2),
  ChipItem(text: 'Sides', value: 3),
  ChipItem(text: 'Pizza', value: 4),
  ChipItem(text: 'Pasta', value: 5),
];

const List<Dish> dummyDishes = [
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=1',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=2',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=3',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=4',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=5',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=1',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=6',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=7',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
  Dish(
      imgSrc: 'https://picsum.photos/400/300?random=8',
      title: 'Pad Thai Noodles',
      description:
          'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
      preparationTime: '12 min',
      priceTag: '£ 8.50'),
];

var dummyCreditCards = [
  CreditCard(
    cardBackground: SolidColorCardBackground(Colors.black.withOpacity(0.6)),
    cardNetworkType: CardNetworkType.visaBasic,
    cardHolderName: 'The boring developer',
    cardNumber: '1234 1234 1234 1234',
    company: CardCompany.yesBank,
    validity: Validity(
      validThruMonth: 1,
      validThruYear: 21,
      validFromMonth: 1,
      validFromYear: 16,
    ),
  ),
  CreditCard(
    cardBackground: SolidColorCardBackground(Colors.red.withOpacity(0.4)),
    cardNetworkType: CardNetworkType.mastercard,
    cardHolderName: 'Gursheesh Singh',
    cardNumber: '2434 2434 **** ****',
    company: CardCompany.kotak,
    validity: Validity(
      validThruMonth: 1,
      validThruYear: 21,
    ),
  ),
  CreditCard(
    cardBackground: GradientCardBackground(LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.blue, Colors.purple],
      stops: [0.3, 0.95],
    )),
    cardNetworkType: CardNetworkType.mastercard,
    cardHolderName: 'Very Very very boring devloper',
    cardNumber: '4567',
    company: CardCompany.sbiCard,
    validity: Validity(
      validThruMonth: 2,
      validThruYear: 2021,
    ),
  ),
];

const dummyWalletOptions = [
  WalletOption('credit-card', 'Visa • 4444'),
  WalletOption('credit-card', 'Master • 6666'),
];
