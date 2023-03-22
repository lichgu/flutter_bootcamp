import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(const CoinTicker());
}

class CoinTicker extends StatelessWidget {
  const CoinTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.black26,
        appBarTheme: AppBarTheme(
          color: kPrimaryColor,
        ),
      ),
      home: const PriceScreen(),
    );
  }
}
