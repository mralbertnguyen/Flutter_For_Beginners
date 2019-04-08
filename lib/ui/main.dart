import 'package:flutter/material.dart';

import 'package:flutter_app/widgets/items/item_mainList.dart';
import 'package:flutter_app/widgets/swipeButton.dart';
import 'package:flutter_app/customLib/loadmore/LoadMoreCus.dart';
import 'package:flutter_app/ui/note_app/login.dart';
import 'package:flutter_app/ui/map.dart';
import 'package:flutter_app/ui/ex_loadmore/MainActivity.dart';
import 'package:flutter_app/ui/radialmenu/RadialMenu.dart';
import 'package:flutter_app/utils/String.dart';

class MainStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MainStateful();
  }
}

class MainStateful extends StatefulWidget {
  MainStateful({Key key}) : super(key: key);

  @override
  MainState createState() => new MainState();
}

/// Main Class will be content example list
/// custom items
class MainState extends State<MainStateful> {
  // Data list
  List<String> dataList = [
    HEADER_NOTE_APP,
    HEADER_MAP,
    HEADER_LOAD_MORE,
    HEADER_SWIPE_BUTTON,
    HEADER_RADIAL_MENU
  ];

  int get count => dataList.length;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: LoadMoreCus(
          isFinish: true,
          child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ItemsMainListOption(dataList[index]),
                  onTap: () {
                    onTapList(context, index);
                  },
                );
              }),
          onLoadMore: _onLoadMore),
    );
  }
}

/// Move screen with index position
/// 0 - Demo APP
/// 1 - Map
/// 2 - List load more example
/// 3 - Swipe button
onTapList(_context, _index) {
  switch (_index) {
    case 0:
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => Login()));
      break;
    case 1:
      Navigator.push(_context, MaterialPageRoute(builder: (context) => Map()));
      break;
    case 2:
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => MainActivity()));
      break;
    case 3:
      Navigator.push(
          _context, MaterialPageRoute(builder: (context) => SwipeDemoApp()));
      break;
    case 4:
      Navigator.push(_context,
          MaterialPageRoute(builder: (context) => RadialMenuStateless()));
      break;
    default:
      break;
  }
}

Future<void> _onRefresh() async {}

Future<bool> _onLoadMore() async {
  return true;
}
