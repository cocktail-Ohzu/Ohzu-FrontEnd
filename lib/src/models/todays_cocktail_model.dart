/*
Dart 에서는 JSON 형식을 class 로 직렬화 해주어야 한다
이 파일은 직렬화된 모델(class)들을 모아놓은 것

JSON to dart
https://javiercbk.github.io/json_to_dart/

API 명세
https://www.notion.so/1-API-9eede01a48ca4bc5b6ffeceab8e773bc

*/

/* 메인 페이지 오늘의 추천 칵테일 모델 */
class TodaysCocktailModel {
  int? id;
  String? img;
  String? img2;
  String? backgroundColor;
  String? name;
  String? engName;
  String? desc;
  int? strength;

  TodaysCocktailModel(
      {this.id,
      this.img,
      this.img2,
      this.backgroundColor,
      this.name,
      this.engName,
      this.desc,
      this.strength});

  TodaysCocktailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    img2 = json['img2'];
    backgroundColor = json['background_color'];
    name = json['name'];
    engName = json['eng_name'];
    desc = json['desc'];
    strength = json['strength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "img": img,
      "img2": img2,
      "background_color": backgroundColor,
      "name": name,
      "eng_name": engName,
      "desc": desc,
      "strength": strength,
    };
    return data;
  }
}
