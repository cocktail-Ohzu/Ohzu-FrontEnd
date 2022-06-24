class RecommendModel {
  List<FitCocktails>? fitCocktails;
  List<SimilarCocktails>? similarCocktails;

  RecommendModel({this.fitCocktails, this.similarCocktails});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    if (json['fit_cocktails'] != null) {
      fitCocktails = <FitCocktails>[];
      json['fit_cocktails'].forEach((v) {
        fitCocktails!.add(FitCocktails.fromJson(v));
      });
    }
    if (json['similar_cocktails'] != null) {
      similarCocktails = <SimilarCocktails>[];
      json['similar_cocktails'].forEach((v) {
        similarCocktails!.add(SimilarCocktails.fromJson(v));
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

class FitCocktails {
  int? id;
  String? name;
  String? img;
  String? backgroundColor;

  FitCocktails({this.id, this.name, this.img, this.backgroundColor});

  FitCocktails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['background_color'] = backgroundColor;
    return data;
  }
}

class SimilarCocktails {
  int? id;
  String? name;
  String? img;
  String? backgroundColor;

  SimilarCocktails({this.id, this.name, this.img, this.backgroundColor});

  SimilarCocktails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['background_color'] = backgroundColor;
    return data;
  }
}
