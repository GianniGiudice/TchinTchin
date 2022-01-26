import 'package:tchintchin/jsondart/full_data_drink.dart';

class DrinkFullDataArray {
  List<FullDataDrink>? _drinks;

  List<FullDataDrink>? get drinks => _drinks;

  DrinkFullDataArray({
      List<FullDataDrink>? drinks}){
    _drinks = drinks;
}

  DrinkFullDataArray.fromJson(dynamic json) {
    if (json['drinks'] != null) {
      _drinks = [];
      json['drinks'].forEach((v) {
        _drinks?.add(FullDataDrink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_drinks != null) {
      map['drinks'] = _drinks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}