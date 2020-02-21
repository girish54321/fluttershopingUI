import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:page_transition/page_transition.dart';

import 'Animations/FadeAnimation.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: 240.0,
                  child: Carousel(animationCurve: Curves.ease,
                    images: [
                      NetworkImage(
                          'https://i.pinimg.com/originals/4a/b9/94/4ab994aa22ef942921a39f48a489ab0d.jpg'),
                      NetworkImage(
                          'https://i.pinimg.com/originals/4a/b9/94/4ab994aa22ef942921a39f48a489ab0d.jpg'),
                      NetworkImage(
                          'https://i.pinimg.com/originals/4a/b9/94/4ab994aa22ef942921a39f48a489ab0d.jpg'),
                      NetworkImage(
                          'https://i.pinimg.com/originals/4a/b9/94/4ab994aa22ef942921a39f48a489ab0d.jpg'),
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.orange,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: false,
                  )),
              SafeArea(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      Text('Choose \na category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(97, 90, 90, 1))),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          FadeAnimation(
                              1.2,
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.all(10),
                                onPressed: () {},
                                color: Color.fromRGBO(251, 53, 105, 0.1),
                                child: Text('Adult',
                                    style: TextStyle(
                                        color: Color.fromRGBO(251, 53, 105, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                          SizedBox(
                            width: 20.0,
                          ),
                          FadeAnimation(
                              1.3,
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.all(10),
                                onPressed: () {},
                                color: Color.fromRGBO(97, 90, 90, 0.1),
                                child: Text('Children',
                                    style: TextStyle(
                                        color: Color.fromRGBO(97, 90, 90, 0.6),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 280,
            width: double.infinity,
            child: ListView(
              padding: EdgeInsets.only(bottom: 20, left: 20),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FadeAnimation(1.3, makeCard(
                    context: context,
                    startColor: Color.fromRGBO(251, 121, 155, 1),
                    endColor: Color.fromRGBO(251, 53, 105, 1),
                    image: 'assets/socks-one.png'
                )),
                FadeAnimation(1.4, makeCard(
                    context: context,
                    startColor: Color.fromRGBO(203, 251, 255, 1),
                    endColor: Color.fromRGBO(81, 223, 234, 1),
                    image: 'assets/socks-two.png'
                )),
              ],
            ),
          )
        ],
      ),
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
        aspectRatio: 4/5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  startColor,
                  endColor
                ],
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 10,
                    offset: Offset(5, 10)
                )
              ]
          ),
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