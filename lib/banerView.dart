import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeBaners extends StatelessWidget {
  final banerswidget;

  const HomeBaners({Key key, this.banerswidget}) : super(key: key);

  void ontap(int number){
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        child: Carousel(
          onImageTap: ontap,
          animationCurve: Curves.ease,
          images: banerswidget,
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.orange,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.transparent,
          borderRadius: false,
        ));
  }
}

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
