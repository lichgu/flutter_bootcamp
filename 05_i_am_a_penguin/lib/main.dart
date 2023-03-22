import 'package:flutter/material.dart';

void main() {
  var colorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
      ),
      home: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          elevation: 4,
          backgroundColor: colorScheme.secondary,
          title: Text(
            'I am a penguin',
            style: TextStyle(
              fontFamily: 'NunitoSansRegular',
              color: colorScheme.onBackground,
              fontSize: 22,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 100,
            ),
            child: Card(
              elevation: 5,
              color: colorScheme.background,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26.0),
                      topRight: Radius.circular(26.0),
                    ),
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 160),
                      child: const Image(
                        image: AssetImage(
                          'assets/images/scandi-107.png',
                        ),
                        fit: BoxFit.contain, // BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: -15,
                      children: [
                        ListTile(
                          title: Text(
                            'Somewhere south',
                            style: TextStyle(
                              fontFamily: 'NunitoSansRegular',
                              color: colorScheme.onBackground,
                              fontSize: 16,
                            ),
                          ),
                          leading: const Icon(Icons.location_on),
                        ),
                        ListTile(
                          title: Text(
                            'Permanently offline',
                            style: TextStyle(
                              fontFamily: 'NunitoSansRegular',
                              color: colorScheme.onBackground,
                              fontSize: 16,
                            ),
                          ),
                          leading: const Icon(Icons.mail),
                        ),
                        ListTile(
                          title: Text(
                            'Skills',
                            style: TextStyle(
                              fontFamily: 'NunitoSansRegular',
                              color: colorScheme.onBackground,
                              fontSize: 16,
                            ),
                          ),
                          leading: const Icon(Icons.task_alt_rounded),
                          subtitle: Text(
                            'Advanced swimming, Fishing',
                            style: TextStyle(
                              fontFamily: 'NunitoSansRegular',
                              color: colorScheme.onBackground,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
