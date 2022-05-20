import 'package:ohzu/src/models/search_model.dart';

/* 해쉬태그 검색 시 해당 텍스트가 있는지 검사 */
bool hasTag(dynamic _list, String _text) {
  _text = _text.toLowerCase().replaceAll(' ', '');
  if (_list is List<Tag>) {
    return _list
        .where((tag) =>
            tag.name!.toLowerCase().replaceAll(' ', '').contains(_text))
        .isNotEmpty;
  } else if (_list is Tag) {
    return _list.name!.toLowerCase().replaceAll(' ', '').contains(_text);
  } else if (_list is String) {
    return _list.toLowerCase().replaceAll(' ', '').contains(_text);
  }
  return false;
}

// SearchModel _elem 에서
// text 가 포함되어 있는 Tag 들의 리스트를 추출하는 함수
// @return List<Tag>
List<Tag> getTag(SearchModel _elem, String _text) {
  List<Tag> ret = [];
  ret +=
      _elem.flavors!.where((flavorElem) => hasTag(flavorElem, _text)).toList();
  ret += _elem.moods!.where((moodElem) => hasTag(moodElem, _text)).toList();
  ret += _elem.weathers!
      .where((weatherElem) => hasTag(weatherElem, _text))
      .toList();
  ret += _elem.ornaments!
      .where((ornamentElem) => hasTag(ornamentElem, _text))
      .toList();
  ret += _elem.bases!
      .where((ingredientElem) => hasTag(ingredientElem, _text))
      .toList();
  ret += _elem.ingredients!
      .where((ingredientElem) => hasTag(ingredientElem, _text))
      .toList();
  return ret;
}

List<SearchModel> getProcessedList(List<SearchModel> _list, String _text) {
  if (_text.startsWith('#')) {
    _text = _text.substring(1).toLowerCase();
    return _list
        .where((element) =>
            hasTag(element.flavors!, _text) ||
            hasTag(element.moods!, _text) ||
            hasTag(element.weathers!, _text) ||
            hasTag(element.ornaments!, _text) ||
            hasTag(element.bases!, _text) ||
            hasTag(element.ingredients!, _text))
        .toList();
  }
  return _list
      .where((element) =>
          hasTag(element.name!, _text) || hasTag(element.engName!, _text))
      .toList();
}
