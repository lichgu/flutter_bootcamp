import 'dart:io' show Platform;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:bitcoin_ticker/constants.dart';
import 'package:bitcoin_ticker/coin_data.dart' as coin_data;
import 'package:bitcoin_ticker/utils.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  final coin_data.CoinData coinData = coin_data.CoinData();
  Map<String, String> rates = {};
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    updateCoinRates();
  }

  void updateCoinRates() async {
    isWaiting = true;
    try {
      dynamic data = await coinData.getCoinRates(currency: _selectedCurrency);
      isWaiting = false;
      setState(() {
        for (String currency in coin_data.cryptoList) {
          rates[currency] = numberFormatter(data[currency]);
        }
      });
    } catch (e) {
      print(e);
      for (String currency in coin_data.cryptoList) {
        rates[currency] = '? (Error)';
      }
    }
  }

  DropdownButton<String> androidDropdown() {
    return DropdownButton(
      value: _selectedCurrency,
      items: getDropDownItems(),
      onChanged: (String? value) {
        setState(() {
          _selectedCurrency = value!;
          updateCoinRates();
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in coin_data.currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return dropDownItems;
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(
          initialItem: coin_data.currenciesList.indexOf(_selectedCurrency)),
      onSelectedItemChanged: (int selectedIndex) {
        setState(() {
          _selectedCurrency = coin_data.currenciesList[selectedIndex];
          updateCoinRates();
        });
      },
      children:
          getPickerItems(), /*List<Widget>.generate(
          coin_data.currenciesList.length, (int index) {
        return Center(
          child: Text(
            coin_data.currenciesList[index],
          ),
        );
      }),*/
    );
  }

  List<Center> getPickerItems() {
    List<Center> dropDownItems = [];
    for (String currency in coin_data.currenciesList) {
      dropDownItems.add(
        Center(
          child: Text(currency),
        ),
      );
    }
    return dropDownItems;
  }

  Column createCardsColumn() {
    // TODO: change column to lis vire if number of cryto currencies is increased
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: createCards(),
    );
  }

  List<CryptoCard> createCards() {
    List<CryptoCard> cards = [];
    for (String cryptoCurrency in coin_data.cryptoList) {
      cards.add(
        CryptoCard(
          cryptoCurrency: cryptoCurrency,
          selectedCurrency: _selectedCurrency,
          rate: isWaiting ? '?' : rates[cryptoCurrency]!,
        ),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          createCardsColumn(),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: kPrimaryColor,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.cryptoCurrency,
    required String selectedCurrency,
    required this.rate,
  }) : _selectedCurrency = selectedCurrency;

  final String cryptoCurrency;
  final String _selectedCurrency;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        //color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                Colors.tealAccent.shade700,
                Colors.purple.shade900,
              ],
              stops: const [0.1, 0.9],
              transform: const GradientRotation(math.pi / 4),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 54,
                  width: 54,
                  child: Image(
                    image: AssetImage(
                        'assets/images/${coin_data.cryptoLogos[cryptoCurrency]}'),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      cryptoCurrency,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${coin_data.cryptoNames[cryptoCurrency]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  '$rate',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '$_selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
