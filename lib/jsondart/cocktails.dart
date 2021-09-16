import 'drink.dart';

class Cocktails {
  List<Drink>? _drinks;

  List<Drink>? get drinks => _drinks;

  Cocktails({
      required List<Drink> drinks}){
    _drinks = drinks;
}

  Cocktails.fromJson(dynamic json) {
    if (json['drinks'] != null) {
      _drinks = [];
      json['drinks'].forEach((v) {
        _drinks?.add(Drink.fromJson(v));
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