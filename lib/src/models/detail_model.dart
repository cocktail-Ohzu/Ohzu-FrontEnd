/* 칵테일 상세 정보 모델 */
class DetailModel {
  Info? info;
  List<Bases>? bases;
  List<Ingredients>? ingredients;

  DetailModel({this.info, this.bases, this.ingredients});

  DetailModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['bases'] != null) {
      bases = <Bases>[];
      json['bases'].forEach((v) {
        bases!.add(Bases.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (bases != null) {
      data['bases'] = bases!.map((v) => v.toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
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
  String? img2;
  String? img3;
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
      this.img2,
      this.img3,
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
    img2 = json['img2'];
    img3 = json['img3'];
    desc = json['desc'];
    strength = json['strength'];
    if (json['flavors'] != null) {
      flavors = <Tag>[];
      json['flavors'].forEach((v) {
        flavors!.add(Tag.fromJson(v));
      });
    }
    if (json['moods'] != null) {
      moods = <Tag>[];
      json['moods'].forEach((v) {
        moods!.add(Tag.fromJson(v));
      });
    }
    if (json['weathers'] != null) {
      weathers = <Tag>[];
      json['weathers'].forEach((v) {
        weathers!.add(Tag.fromJson(v));
      });
    }
    if (json['ornaments'] != null) {
      ornaments = <Tag>[];
      json['ornaments'].forEach((v) {
        ornaments!.add(Tag.fromJson(v));
      });
    }
    recipe = json['recipe'];
    ohzuPoint = json['ohzu_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['background_color'] = backgroundColor;
    data['eng_name'] = engName;
    data['img'] = img;
    data['img2'] = img2;
    data['img3'] = img3;
    data['desc'] = desc;
    data['strength'] = strength;
    if (flavors != null) {
      data['flavors'] = flavors!.map((v) => v.toJson()).toList();
    }
    if (moods != null) {
      data['moods'] = moods!.map((v) => v.toJson()).toList();
    }
    if (weathers != null) {
      data['weathers'] = weathers!.map((v) => v.toJson()).toList();
    }
    if (ornaments != null) {
      data['ornaments'] = ornaments!.map((v) => v.toJson()).toList();
    }
    data['recipe'] = recipe;
    data['ohzu_point'] = ohzuPoint;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tag_color'] = tagColor;
    return data;
  }
}

class Bases {
  String? base;
  String? tagColor;
  String? desc;

  Bases({this.base, this.tagColor, this.desc});

  Bases.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    tagColor = json['tag_color'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base'] = base;
    data['tag_color'] = tagColor;
    data['desc'] = desc;
    return data;
  }
}

class Ingredients {
  String? ingredient;
  String? tagColor;
  String? amount;
  String? desc;

  Ingredients({this.ingredient, this.tagColor, this.amount});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'];
    tagColor = json['tag_color'];
    amount = json['amount'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredient'] = ingredient;
    data['tag_color'] = tagColor;
    data['amount'] = amount;
    data['desc'] = desc;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tag_color'] = tagColor;
    return data;
  }
}
