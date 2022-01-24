class Category {
  String? _strCategory;

  String? get strCategory => _strCategory;

  Category({
      String? strCategory}){
    _strCategory = strCategory!;
}

  Category.fromJson(dynamic json) {
    _strCategory = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['strCategory'] = _strCategory;
    return map;
  }

}