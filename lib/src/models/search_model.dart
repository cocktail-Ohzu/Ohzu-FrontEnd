class SearchModel {
  int? id;
  String? name;
  String? engName;
  String? img;
  String? backgroundColor;
  List<Tag>? bases;
  List<Tag>? ingredients;
  List<Tag>? flavors;
  List<Tag>? moods;
  List<Tag>? weathers;
  List<Tag>? ornaments;

  SearchModel(
      {this.id,
      this.name,
      this.engName,
      this.img,
      this.backgroundColor,
      this.bases,
      this.ingredients,
      this.flavors,
      this.moods,
      this.weathers,
      this.ornaments});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    engName = json['eng_name'];
    img = json['img'];
    backgroundColor = json['background_color'];
    if (json['bases'] != null) {
      bases = <Tag>[];
      json['bases'].forEach((v) {
        bases!.add(Tag.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Tag>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Tag.fromJson(v));
      });
    }
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['eng_name'] = engName;
    data['img'] = img;
    data['background_color'] = backgroundColor;
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
