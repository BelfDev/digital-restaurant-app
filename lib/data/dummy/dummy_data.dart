import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:dr_app/data/models/wallet_option.dart';
import 'package:flutter/material.dart';

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
