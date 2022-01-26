class FullDataDrink {
  String? _idDrink;
  String? _strDrink;
  String? _strDrinkAlternate;
  String? _strTags;
  String? _strVideo;
  String? _strCategory;
  String? _strIBA;
  String? _strAlcoholic;
  String? _strGlass;
  String? _strInstructions;
  String? _strInstructionsFR;
  String? _strDrinkThumb;
  String? _strIngredient1;
  String? _strIngredient2;
  String? _strIngredient3;
  String? _strIngredient4;
  String? _strMeasure1;
  String? _strMeasure2;
  String? _strMeasure3;
  String? _strMeasure4;
  String? _strCreativeCommonsConfirmed;
  String? _dateModified;

  String? get idDrink => _idDrink;
  String? get strDrink => _strDrink;
  String? get strDrinkAlternate => _strDrinkAlternate;
  String? get strTags => _strTags;
  String? get strVideo => _strVideo;
  String? get strCategory => _strCategory;
  String? get strIBA => _strIBA;
  String? get strAlcoholic => _strAlcoholic;
  String? get strGlass => _strGlass;
  String? get strInstructions => _strInstructions;
  String? get strInstructionsFR => _strInstructionsFR;
  String? get strDrinkThumb => _strDrinkThumb;
  String? get strIngredient1 => _strIngredient1;
  String? get strIngredient2 => _strIngredient2;
  String? get strIngredient3 => _strIngredient3;
  String? get strIngredient4 => _strIngredient4;
  String? get strMeasure1 => _strMeasure1;
  String? get strMeasure2 => _strMeasure2;
  String? get strMeasure3 => _strMeasure3;
  String? get strMeasure4 => _strMeasure4;
  String? get strCreativeCommonsConfirmed => _strCreativeCommonsConfirmed;
  String? get dateModified => _dateModified;

  FullDataDrink({
      String? idDrink,
      String? strDrink,
      String? strDrinkAlternate,
      String? strTags,
      String? strVideo,
      String? strCategory,
      String? strIBA,
      String? strAlcoholic,
      String? strGlass,
      String? strInstructions,
      String? strInstructionsFR,
      String? strDrinkThumb,
      String? strIngredient1,
      String? strIngredient2,
      String? strIngredient3,
      String? strIngredient4,
      String? strMeasure1,
      String? strMeasure2,
      String? strMeasure3,
      String? strMeasure4,
      String? strCreativeCommonsConfirmed,
      String? dateModified}){
    _idDrink = idDrink;
    _strDrink = strDrink;
    _strDrinkAlternate = strDrinkAlternate;
    _strTags = strTags;
    _strVideo = strVideo;
    _strCategory = strCategory;
    _strIBA = strIBA;
    _strAlcoholic = strAlcoholic;
    _strGlass = strGlass;
    _strInstructions = strInstructions;
    _strInstructionsFR = strInstructionsFR;
    _strDrinkThumb = strDrinkThumb;
    _strIngredient1 = strIngredient1;
    _strIngredient2 = strIngredient2;
    _strIngredient3 = strIngredient3;
    _strIngredient4 = strIngredient4;
    _strMeasure1 = strMeasure1;
    _strMeasure2 = strMeasure2;
    _strMeasure3 = strMeasure3;
    _strMeasure4 = strMeasure4;
    _strCreativeCommonsConfirmed = strCreativeCommonsConfirmed;
    _dateModified = dateModified;
}

  FullDataDrink.fromJson(dynamic json) {
    _idDrink = json['idDrink'];
    _strDrink = json['strDrink'];
    _strDrinkAlternate = json['strDrinkAlternate'];
    _strTags = json['strTags'];
    _strVideo = json['strVideo'];
    _strCategory = json['strCategory'];
    _strIBA = json['strIBA'];
    _strAlcoholic = json['strAlcoholic'];
    _strGlass = json['strGlass'];
    _strInstructions = json['strInstructions'];
    _strInstructionsFR = json['strInstructionsFR'];
    _strDrinkThumb = json['strDrinkThumb'];
    _strIngredient1 = json['strIngredient1'];
    _strIngredient2 = json['strIngredient2'];
    _strIngredient3 = json['strIngredient3'];
    _strIngredient4 = json['strIngredient4'];
    _strMeasure1 = json['strMeasure1'];
    _strMeasure2 = json['strMeasure2'];
    _strMeasure3 = json['strMeasure3'];
    _strMeasure4 = json['strMeasure4'];
    _strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed'];
    _dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['idDrink'] = _idDrink;
    map['strDrink'] = _strDrink;
    map['strDrinkAlternate'] = _strDrinkAlternate;
    map['strTags'] = _strTags;
    map['strVideo'] = _strVideo;
    map['strCategory'] = _strCategory;
    map['strIBA'] = _strIBA;
    map['strAlcoholic'] = _strAlcoholic;
    map['strGlass'] = _strGlass;
    map['strInstructions'] = _strInstructions;
    map['strInstructionsFR'] = _strInstructionsFR;
    map['strDrinkThumb'] = _strDrinkThumb;
    map['strIngredient1'] = _strIngredient1;
    map['strIngredient2'] = _strIngredient2;
    map['strIngredient3'] = _strIngredient3;
    map['strIngredient4'] = _strIngredient4;
    map['strMeasure1'] = _strMeasure1;
    map['strMeasure2'] = _strMeasure2;
    map['strMeasure3'] = _strMeasure3;
    map['strMeasure4'] = _strMeasure4;
    map['strCreativeCommonsConfirmed'] = _strCreativeCommonsConfirmed;
    map['dateModified'] = _dateModified;
    return map;
  }

}