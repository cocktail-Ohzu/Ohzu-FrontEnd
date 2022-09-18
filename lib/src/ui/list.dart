import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohzu/src/utils/search_util.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/ui/detail.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.itemList}) : super(key: key);
  final List<SearchModel> itemList;

  @override
  State<ListPage> createState() => _ListPageState(itemList: itemList);
}

class _ListPageState extends State<ListPage> {
  /* 검색창으로 부터 넘어온 fetched item */
  final List<SearchModel> itemList;
  _ListPageState({required this.itemList});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.transparent,
        elevation: 0,

        // leadingWidth: 60,
        leadingWidth: 50,
        actions: const [],
      ),
      body: buildResultByTag(
        itemList,
      ),
    );
  }

  Widget buildResultByTag(List<SearchModel> _list) {
    final int len = _list.length;
    List<Widget> ret = [];
    String cocktailName;

    List<Tag> tagToShow = [];
    int tagToShowLen;

    for (int i = 0; i < len; ++i) {
      cocktailName = _list[i].name!;
      tagToShow = getTag(_list[i], '');
      tagToShowLen = tagToShow.length > 2 ? 2 : tagToShow.length;

      if (tagToShowLen > 0) {
        ret.add(
          Container(
            padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
            child: GestureDetector(
              onTap: () {
                openDetailPage(context, _list[i].id!);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1e1e1e),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /* 태그 검색 시 칵테일 사진 */
                    Container(
                      alignment: Alignment.topCenter,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        image: DecorationImage(
                            image: Image.network(
                              _list[i].img4!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset('asset/images/c.png',
                                    fit: BoxFit.cover);
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                // print("loading!!!!");
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ).image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 13, 12, 12),
                          child: Text(
                            cocktailName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: cocktailName.length > 9 ? 15 : 16),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "alcohol ${_list[i].strength ?? "??"}%",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFDA6C31),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return GridView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      shrinkWrap: true,
      children: [for (int i = 0; i < ret.length; ++i) ret[i]],
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 210,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12),
    );
  }

  /* 태그 블록 위젯 */
  Widget buildTagItem(Text text, String colorCode) {
    return Container(
        decoration: BoxDecoration(
          color: Color(int.parse("0xf$colorCode")).withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: text);
  }
}

/* 이 페이지 오픈 */
void openListPage(BuildContext context, List<SearchModel> itemList) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => ListPage(itemList: itemList),
    ),
  );
}
