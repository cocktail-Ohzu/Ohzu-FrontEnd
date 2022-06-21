/*
Dart 에서는 JSON 형식을 class 로 직렬화 해주어야 한다
이 파일은 직렬화된 모델(class)들을 모아놓은 것

JSON to dart
https://javiercbk.github.io/json_to_dart/

API 명세
https://www.notion.so/1-API-9eede01a48ca4bc5b6ffeceab8e773bc

*/

/* 메인 페이지 오늘의 추천 칵테일 모델 */
class RecommendModel {
  int? id;
  String? img;
  String? backgroundColor;
  String? name;
  String? engName;
  String? desc;
  int? strength;

  RecommendModel(
      {this.id,
      this.img,
      this.backgroundColor,
      this.name,
      this.engName,
      this.desc,
      this.strength});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
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
      "background_color": backgroundColor,
      "name": name,
      "eng_name": engName,
      "desc": desc,
      "strength": strength,
    };
    return data;
  }
}
