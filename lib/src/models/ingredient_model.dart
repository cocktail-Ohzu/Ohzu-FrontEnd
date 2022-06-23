class IngredientModel {
  List<IngredientElement>? bases;
  List<IngredientElement>? ingredients;
  List<IngredientElement>? flavors;
  List<IngredientElement>? moods;
  List<IngredientElement>? weathers;
  List<IngredientElement>? ornaments;

  IngredientModel(
      {this.bases,
      this.ingredients,
      this.flavors,
      this.moods,
      this.weathers,
      this.ornaments});

  IngredientModel.fromJson(Map<String, dynamic> json) {
    if (json['bases'] != null) {
      bases = <IngredientElement>[];
      json['bases'].forEach((v) {
        bases!.add(IngredientElement.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <IngredientElement>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(IngredientElement.fromJson(v));
      });
    }
    if (json['flavors'] != null) {
      flavors = <IngredientElement>[];
      json['flavors'].forEach((v) {
        flavors!.add(IngredientElement.fromJson(v));
      });
    }
    if (json['moods'] != null) {
      moods = <IngredientElement>[];
      json['moods'].forEach((v) {
        moods!.add(IngredientElement.fromJson(v));
      });
    }
    if (json['weathers'] != null) {
      weathers = <IngredientElement>[];
      json['weathers'].forEach((v) {
        weathers!.add(IngredientElement.fromJson(v));
      });
    }
    if (json['ornaments'] != null) {
      ornaments = <IngredientElement>[];
      json['ornaments'].forEach((v) {
        ornaments!.add(IngredientElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bases != null) {
      data['bases'] = bases!.map((v) => v.toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
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
    return data;
  }
}

class IngredientElement {
  int? id;
  String? name;
  String? img;
  String? tagColor;
  String? desc;

  IngredientElement({this.id, this.name, this.img, this.tagColor, this.desc});

  IngredientElement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    tagColor = json['tag_color'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['tag_color'] = tagColor;
    return data;
  }
}
