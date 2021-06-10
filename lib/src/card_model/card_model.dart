class CardModel {
  String user;
  String cardNumber;
  String cardExpired;
  String cardType;
  int cardBackground;
  String cardElementTop;
  String cardElementBottom;
  double cardLimit;

  CardModel(this.user, this.cardNumber, this.cardExpired, this.cardType,
      this.cardBackground, this.cardElementTop, this.cardElementBottom, this.cardLimit);
}

List<CardModel> cards = cardData
    .map(
      (item) => CardModel(
    item['user'],
    item['cardNumber'],
    item['cardExpired'],
    item['cardType'],
    item['cardBackground'],
    item['cardElementTop'],
    item['cardElementBottom'],
    item['cardLimit']
  ),
)
    .toList();

var cardData = [
  {
    "user": "Lucas Silva Borges Ferreira",
    "cardNumber": "**** **** **** 1425",
    "cardExpired": "03-01-2023",
    "cardType": "assets/images/mastercard_logo.png",
    "cardBackground": 0xFF1E1E99,
    "cardElementTop": "assets/svg/ellipse_top_pink.svg",
    "cardElementBottom": "assets/svg/ellipse_bottom_pink.svg",
    "cardLimit": 12000.00
  },
  {
    "user": "Thiago Magno",
    "Número do cartão": "**** **** **** 8287",
    "Vencimento": "03-01-2025",
    "cardType": "assets/images/mastercard_logo.png",
    "cardBackground": 0xFFFF70A3,
    "cardElementTop": "assets/svg/ellipse_top_blue.svg",
    "cardElementBottom": "assets/svg/ellipse_bottom_blue.svg",
    "cardLimit": 23000.00
  }
];
