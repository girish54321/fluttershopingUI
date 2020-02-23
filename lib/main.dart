import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:page_transition/page_transition.dart';

import 'Animations/FadeAnimation.dart';
import 'banerView.dart';
import 'modal/Baners.dart';
import 'network_utils/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopingHome(),
    );
  }
}

class ShopingHome extends StatefulWidget {
  @override
  _ShopingHomeState createState() => _ShopingHomeState();
}

class _ShopingHomeState extends State<ShopingHome> {
  int _selectedItemPosition = 2;
  bool _isLoading = true;
  BanerResones banerResones;
  List<Baner> banerList;
  List<Widget> banerswidget = [];

  @override
  void initState() {
    _getBaners();
    super.initState();
  }

  void _getBaners() async {
    setState(() {
      _isLoading = true;
    });
    var res = await Network().getData('https://api.myjson.com/bins/82haw');
    var body = json.decode(res.body);
    print("BANERS PLZ========================================");
    print(res.statusCode);

    if (res.statusCode == 200) {
      banerResones = new BanerResones.fromJson(body);
      banerList = banerResones.baners;
      banerswidget = banerResones.baners.asMap().entries.map((MapEntry map) {
        return CachedNetworkImage(
          fadeInDuration: Duration(seconds: 1),
          fit: BoxFit.cover,
          height: 240,
          imageUrl: banerResones.baners[map.key].imageUrl,
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      }).toList();
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                _isLoading
                    ? Text("")
                    : FadeAnimation(
                        1,
                        HomeBaners(
                          banerswidget: banerswidget,
                        ),
                      ),
                MyAppbar(),
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 80.0, // I'm forcing item heights
            delegate: SliverChildBuilderDelegate((context, index) {
              Baner banner = banerList[index];
              return FadeAnimation(
                0.3,
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(banner.imageUrl)),
                    title: Text(
                      banner.blurhash,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    subtitle: Text(
                      banner.blurhash,
                    ),
                  ),
                ),
              );
            }, childCount: banerList.length),
          ),
        ],
      ),
//      body: _isLoading
//          ? Text("")
//          : ListView.builder(
//              itemCount: banerList.length,
//              itemBuilder: (context, index) {
//                Baner banner = banerList[index];
//                return  CachedNetworkImage(
//                  fadeInDuration: Duration(seconds: 1),
//                  fit: BoxFit.cover,
//                  height: 100,
//                  imageUrl: banner.imageUrl,
//                  placeholder: (context, url) => Container(
//                    height: 100,
//                    child: BlurHash(hash: banner.blurhash),
//                  ),
//                  errorWidget: (context, url, error) => Icon(Icons.error),
//                );
//              },
//            ),
      bottomNavigationBar: SnakeNavigationBar(
        snakeColor: Colors.red,
        style: SnakeBarStyle.pinned,
        backgroundColor: Colors.white,
        currentIndex: _selectedItemPosition,
        onPositionChanged: (index) =>
            setState(() => _selectedItemPosition = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat), title: Text('tickets')),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text('calendar')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic), title: Text('microphone')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('search'))
        ],
      ),
    );
  }

  Widget makeCard({context, startColor, endColor, image}) {
    return GestureDetector(
      onTap: () {
//        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ViewSocks()));
      },
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [startColor, endColor],
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 10,
                    offset: Offset(5, 10))
              ]),
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Center(
              child: Image.asset(image),
            ),
          ),
        ),
      ),
    );
  }
}
