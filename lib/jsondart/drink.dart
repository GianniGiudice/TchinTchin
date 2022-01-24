class Drink {
  String? _strDrink;
  String? _strDrinkThumb;
  String? _idDrink;

  String? get strDrink => _strDrink;
  String? get strDrinkThumb => _strDrinkThumb;
  String? get idDrink => _idDrink;

  Drink({
      String? strDrink,
      String? strDrinkThumb,
      String? idDrink}){
    _strDrink = strDrink!;
    _strDrinkThumb = strDrinkThumb!;
    _idDrink = idDrink!;
}

  Drink.fromJson(dynamic json) {
    _strDrink = json['strDrink'];
    _strDrinkThumb = json['strDrinkThumb'];
    _idDrink = json['idDrink'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['strDrink'] = _strDrink;
    map['strDrinkThumb'] = _strDrinkThumb;
    map['idDrink'] = _idDrink;
    return map;
  }

}