import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:provider/provider.dart';
import 'deck.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Deck(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const BlackjackHome(),
    );
  }
}

class BlackjackHome extends StatefulWidget {
  const BlackjackHome({super.key});

  @override
  State<BlackjackHome> createState() => _BlackjackHomeState();
}

class _BlackjackHomeState extends State<BlackjackHome> {
  ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.black, width: 1));

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(body: SafeArea(
        child: Consumer<Deck>(builder: (context, deck, child) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Player hand"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        child: Text('Hit'),
                        onPressed: () {
                          deck.drawForPlayer();
                        }),
                    TextButton(
                        child: Text('Stay'),
                        onPressed: () {
                          deck.determineGameResult();
                        }),
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: deck
                                    .getPlayerHand()
                                    .map(
                                      (card) => PlayingCardView(
                                        card: card,
                                        shape: shape,
                                        elevation: 3,
                                      ),
                                    )
                                    .toList())),
                      ]),
                ),
                Text("Dealer hand"),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                      height: 150.0,
                      width: deck.getDealerHand().length * 50,
                      child: FlatCardFan(
                          children: deck
                              .getDealerHand()
                              .mapIndexed(
                                (index, card) => PlayingCardView(
                                  card: card,
                                  showBack:
                                      index == deck.getDealerHand().length - 1
                                          ? false
                                          : true,
                                  shape: shape,
                                  elevation: 3.0,
                                ),
                              )
                              .toList())),
                ]),
                TextButton(
                    child: Text('Reset Deck'),
                    onPressed: () {
                      deck.resetDeckAndHands();
                    }),
                TextButton(
                    child: Text('New Game'),
                    onPressed: () {
                      deck.resetDeckAndHands();
                      deck.populateInitialHands();
                    }),
              ]);
        }),
      ));
    });
  }
}
