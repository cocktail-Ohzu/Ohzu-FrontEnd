class RecommendModel {
  List<RecommendCocktail>? fitCocktails;
  List<RecommendCocktail>? similarCocktails;

  RecommendModel({this.fitCocktails, this.similarCocktails});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    if (json['fit_cocktails'] != null) {
      fitCocktails = <RecommendCocktail>[];
      json['fit_cocktails'].forEach((v) {
        fitCocktails!.add(RecommendCocktail.fromJson(v));
      });
    }
    if (json['similar_cocktails'] != null) {
      similarCocktails = <RecommendCocktail>[];
      json['similar_cocktails'].forEach((v) {
        similarCocktails!.add(RecommendCocktail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fitCocktails != null) {
      data['fit_cocktails'] = fitCocktails!.map((v) => v.toJson()).toList();
    }
    if (similarCocktails != null) {
      data['similar_cocktails'] =
          similarCocktails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendCocktail {
  int? id;
  String? name;
  String? img;
  String? img2;
  String? backgroundColor;

  RecommendCocktail(
      {this.id, this.name, this.img, this.img2, this.backgroundColor});

  RecommendCocktail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    img2 = json['img2'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['img2'] = img2;
    data['background_color'] = backgroundColor;
    return data;
  }
}
