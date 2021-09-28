/// strDrink : "155 Belmont"
/// strDrinkThumb : "https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg"
/// idDrink : "15346"

class Cocktail {
  String? _strDrink;
  String? _strDrinkThumb;
  String? _idDrink;

  String? get strDrink => _strDrink;
  String? get strDrinkThumb => _strDrinkThumb;
  String? get idDrink => _idDrink;

  Cocktail({
      String? strDrink, 
      String? strDrinkThumb, 
      String? idDrink}){
    _strDrink = strDrink;
    _strDrinkThumb = strDrinkThumb;
    _idDrink = idDrink;
}

  Cocktail.fromJson(dynamic json) {
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