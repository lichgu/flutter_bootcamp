import 'package:flutter/material.dart';

import 'screens/input_page.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color.fromARGB(255, 14, 16, 32), // old version: Color(0xff0a0e21)
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 14, 16, 32),
      ),
      home: const InputPage(),
    );
  }
}

// example: special theme for particular FloatingActionButton
/*floatingActionButton: Theme(
  data: ThemeData(
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colors.purple),
  ),
  child: FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {},
  ),
),*/
