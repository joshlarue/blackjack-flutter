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
      return Scaffold(
          body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Player hand"),
            Row(children: [
              Expanded(
                  child: SizedBox(
                height: 150.0,
                child: Consumer<Deck>(builder: (context, deck, child) {
                  return ListView(
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
                        .toList(),
                  );
                }),
              )),
            ]),
            Text("Dealer hand"),
            Row(children: [
              SizedBox(
                height: 150.0,
                width: 150,
                child: Consumer<Deck>(builder: (context, deck, child) {
                  return FlatCardFan(
                      children: deck
                          .getDealerHand()
                          .mapIndexed(
                            (index, card) => PlayingCardView(
                              card: card,
                              showBack: index == deck.getDealerHand().length - 1
                                  ? false
                                  : true,
                              shape: shape,
                              elevation: 3.0,
                            ),
                          )
                          .toList());
                }),
              ),
            ]),
            Consumer<Deck>(builder: (context, deck, child) {
              return TextButton(
                  child: Text('draw card'),
                  onPressed: () {
                    deck.drawForPlayer();
                  });
            }),
            Consumer<Deck>(builder: (context, deck, child) {
              return TextButton(
                  child: Text('Reset Deck'),
                  onPressed: () {
                    deck.resetDeckAndHands();
                  });
            }),
            Consumer<Deck>(builder: (context, deck, child) {
              return TextButton(
                  child: Text('New Game'),
                  onPressed: () {
                    deck.resetDeckAndHands();
                    deck.populateInitialHands();
                  });
            }),
          ],
        ),
      ));
    });
  }
}
