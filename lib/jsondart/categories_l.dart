import 'package:tchintchin/jsondart/category.dart';

class CategoriesL {
  List<Category>? _drinks;

  List<Category>? get drinks => _drinks;

  CategoriesL({
      required List<Category>? drinks}){
    _drinks = drinks;
}

  CategoriesL.fromJson(dynamic json) {
    if (json['drinks'] != null) {
      _drinks = [];
      json['drinks'].forEach((v) {
        _drinks?.add(Category.fromJson(v));
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