import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/foundation.dart';

class Deck extends ChangeNotifier {
  List<PlayingCard> _deck;
  List<PlayingCard> dealerHand = [];
  List<PlayingCard> playerHand = [];

  Deck() : _deck = _createAndShuffleDeck();

  void resetDeckAndHands() {
    _deck = [];
    playerHand = [];
    dealerHand = [];
    _deck = _createAndShuffleDeck();
    notifyListeners();
  }

  void populateInitialHands() {
    for (int i = 0; i < 3; i++) {
      drawForDealer();
    }

    for (int i = 0; i < 2; i++) {
      drawForPlayer();
    }
  }

  static List<PlayingCard> _createAndShuffleDeck() {
    List<PlayingCard> deck = standardFiftyTwoCardDeck();
    deck.shuffle();
    return deck;
  }

  List<PlayingCard> getDeck() {
    return _deck;
  }

  List<PlayingCard> getDealerHand() {
    return dealerHand;
  }

  List<PlayingCard> getPlayerHand() {
    return playerHand;
  }

  void shuffleDeck() {
    _deck.shuffle();
    notifyListeners();
  }

  void drawForDealer() {
    if (_deck.isNotEmpty) {
      PlayingCard poppedCard = _deck.removeLast();
      notifyListeners();
      dealerHand.add(poppedCard);
    } else {
      throw Exception("There are no cards in the deck to draw.");
    }
  }

  void drawForPlayer() {
    if (_deck.isNotEmpty) {
      PlayingCard poppedCard = _deck.removeLast();
      notifyListeners();
      playerHand.add(poppedCard);
    } else {
      throw Exception("There are no cards in the deck to draw.");
    }
  }
}
