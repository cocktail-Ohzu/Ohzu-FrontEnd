import 'package:http/http.dart' as http;
import 'dart:convert';

/* 칵테일 상세 정보 모델 */
class DetailModel {
  Info? info;
  List<Bases>? bases;
  List<Ingredients>? ingredients;

  DetailModel({this.info, this.bases, this.ingredients});

  DetailModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['bases'] != null) {
      bases = <Bases>[];
      json['bases'].forEach((v) {
        bases!.add(new Bases.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.bases != null) {
      data['bases'] = this.bases!.map((v) => v.toJson()).toList();
    }
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? id;
  String? name;
  String? backgroundColor;
  String? engName;
  String? img;
  String? desc;
  int? strength;
  List<Tag>? flavors;
  List<Tag>? moods;
  List<Tag>? weathers;
  List<Tag>? ornaments;
  String? recipe;
  String? ohzuPoint;

  Info(
      {this.id,
      this.name,
      this.backgroundColor,
      this.engName,
      this.img,
      this.desc,
      this.strength,
      this.flavors,
      this.moods,
      this.weathers,
      this.ornaments,
      this.recipe,
      this.ohzuPoint});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    backgroundColor = json['background_color'];
    engName = json['eng_name'];
    img = json['img'];
    desc = json['desc'];
    strength = json['strength'];
    if (json['flavors'] != null) {
      flavors = <Tag>[];
      json['flavors'].forEach((v) {
        flavors!.add(new Tag.fromJson(v));
      });
    }
    if (json['moods'] != null) {
      moods = <Tag>[];
      json['moods'].forEach((v) {
        moods!.add(new Tag.fromJson(v));
      });
    }
    if (json['weathers'] != null) {
      weathers = <Tag>[];
      json['weathers'].forEach((v) {
        weathers!.add(new Tag.fromJson(v));
      });
    }
    if (json['ornaments'] != null) {
      ornaments = <Tag>[];
      json['ornaments'].forEach((v) {
        ornaments!.add(new Tag.fromJson(v));
      });
    }
    recipe = json['recipe'];
    ohzuPoint = json['ohzu_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['background_color'] = this.backgroundColor;
    data['eng_name'] = this.engName;
    data['img'] = this.img;
    data['desc'] = this.desc;
    data['strength'] = this.strength;
    if (this.flavors != null) {
      data['flavors'] = this.flavors!.map((v) => v.toJson()).toList();
    }
    if (this.moods != null) {
      data['moods'] = this.moods!.map((v) => v.toJson()).toList();
    }
    if (this.weathers != null) {
      data['weathers'] = this.weathers!.map((v) => v.toJson()).toList();
    }
    if (this.ornaments != null) {
      data['ornaments'] = this.ornaments!.map((v) => v.toJson()).toList();
    }
    data['recipe'] = this.recipe;
    data['ohzu_point'] = this.ohzuPoint;
    return data;
  }
}

class Flavors {
  String? name;
  String? tagColor;

  Flavors({this.name, this.tagColor});

  Flavors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tagColor = json['tag_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tag_color'] = this.tagColor;
    return data;
  }
}

class Bases {
  String? base;
  String? tagColor;
  Null? desc;

  Bases({this.base, this.tagColor, this.desc});

  Bases.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    tagColor = json['tag_color'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    data['tag_color'] = this.tagColor;
    data['desc'] = this.desc;
    return data;
  }
}

class Ingredients {
  String? ingredient;
  String? tagColor;
  String? amount;

  Ingredients({this.ingredient, this.tagColor, this.amount});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'];
    tagColor = json['tag_color'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredient'] = this.ingredient;
    data['tag_color'] = this.tagColor;
    data['amount'] = this.amount;
    return data;
  }
}

class Tag {
  String? name;
  String? tagColor;

  Tag({this.name, this.tagColor});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tagColor = json['tag_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tag_color'] = this.tagColor;
    return data;
  }
}
