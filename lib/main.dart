import 'package:flutter/material.dart';
import 'package:furniture_app/product.dart';
import 'custom_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'data.dart';
import 'package:flutter/cupertino.dart';
import 'color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentindex = 0;
  productClick(data) {
    Navigator.push(
        context,
        new CupertinoPageRoute(
            builder: (context) => new ProductPage(data: data)));
  }

  var _appbar = new Container(
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new IconButton(
          icon: Icon(
            CustomIcons.menu,
            color: black,
          ),
          onPressed: () {},
        ),
        new IconButton(
          icon: Icon(
            CustomIcons.search,
            color: black,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
  var _title = new Expanded(
    flex: 0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: new AutoSizeText(
            "Furniture App",
            style: TextStyle(
                fontFamily: "Montserrat", fontSize: 20.0, color: black),
            maxLines: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: new AutoSizeText(
            "lorem ipsum",
            style: TextStyle(
                fontFamily: "Montserrat", fontSize: 10.0, color: black),
            maxLines: 1,
          ),
        ),
      ],
    ),
  );
  Widget _items(height, width) {
    return new Expanded(
        flex: 2,
        child: new ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, i) {
            return new Container(
              width: width / 1.8,
              // color: (i % 2 == 0) ? Colors.black : Colors.yellow,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
              child: new InkWell(
                onTap: () {
                  productClick(items[i]);
                },
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: height / 13),
                      decoration: BoxDecoration(
                          color: (i % 2 == 0) ? black : white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 5.0),
                                blurRadius: 10.0)
                          ]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 55.0, right: 55.0, top: 0.0),
                          child: new Image.asset(
                            items[i]['image'],
                            height: height / 4,
                            width: width / 4,
                            fit: BoxFit.contain,
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          child: new Text(
                            items[i]["title"],
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15.0,
                              color: (i % 2 == 0) ? white : black,
                            ),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          child: new Text(
                            "NEW SELL",
                            style: TextStyle(
                              color: (i % 2 == 0) ? white : black,
                            ),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(
                              left: 20.0, top: 10.0, bottom: 10.0),
                          child: new Text(
                            items[i]["price"] + " \$",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 20.0,
                              color: (i % 2 == 0) ? white : black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  _body(height, width) {
    double pad = 15.0;
    return new Container(
      margin: EdgeInsets.only(left: pad, right: pad),
      height: height - height * .2,
      width: width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[_title, _items(height, width)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return new Scaffold(
      body: new SafeArea(
        child: new Column(
          children: <Widget>[_appbar, _body(height, width)],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        fixedColor: black,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
        currentIndex: _currentindex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.panorama_horizontal),
              title: new Container(
                height: 0.0,
              )),
          new BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              title: new Container(
                height: 0.0,
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new Container(
        height: 50.0,
        width: 50.0,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: orange, boxShadow: [
          BoxShadow(
              color: orange.withOpacity(.6),
              offset: Offset(0.0, 10.0),
              blurRadius: 10.0)
        ]),
        child: new RawMaterialButton(
          shape: CircleBorder(),
          child: new Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
