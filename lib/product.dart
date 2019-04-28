import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/color.dart';
import 'dart:math' as math;
import 'data.dart';
import 'package:furniture_app/custom_icon.dart';

class ProductPage extends StatefulWidget {
  final data;
  ProductPage({this.data});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  _topimage(height, width, data) {
    return new Stack(
      children: <Widget>[
        new Container(
          color: white,
        ),
        new SizedBox(
          height: height / 1.3,
          width: width,
          child: new Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50.0)),
                image: DecorationImage(
                    image: AssetImage('assets/background.jpeg'),
                    fit: BoxFit.cover)),
          ),
        ),
        new Positioned(
          top: height / 20,
          left: 0,
          child: new Container(
              child: new IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
        ),
        new Positioned(
          top: height / 3.5,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: new Text(
                  data['title'],
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: new Text(
                  "NEW SELL",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: new Text(
                  data['price'] + "\$",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 30.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _bottomBar(height, width) {
    return new Align(
        alignment: Alignment.bottomRight,
        child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    color: orange,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20.0))),
                width: width / 6,
                height: height / 12,
                child: new Icon(
                  CustomIcons.heart,
                  color: Colors.white,
                ),
              ),
              new Container(
                width: width / 6,
                height: height / 12,
                decoration: BoxDecoration(color: black),
                child: new Icon(
                  CustomIcons.bag,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }

  _body(height) {
    return new Container(
        color: white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new AutoSizeText(
                maintext,
                maxLines: 2,
                style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: new AutoSizeText(
                  longtext,
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 10.0),
                ),
              ),
              new Container(
                height: height / 12,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var minheight = height / 2;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                      maxHeight: height / 1.3,
                      minHeight: minheight,
                      child: _topimage(height, width, data)),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [_body(height)],
                  ),
                ),
              ]),
          _bottomBar(height, width)
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
