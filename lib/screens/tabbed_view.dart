import 'dart:convert';

import 'package:doc_scanner/screens/homepahe.dart';
import 'package:doc_scanner/screens/list_page.dart';
import 'package:flutter/material.dart';

class TabbedViewPage extends StatefulWidget {
  static final String path = "lib/src/pages/grocery/ghome.dart";
  static String routeName = 'bottomNav2';
  @override
  TabbedViewPageState createState() {
    return new TabbedViewPageState();
  }
}

class TabbedViewPageState extends State<TabbedViewPage> {
  String name = 'You';
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];

  String token;

  String userID;

  String serviceProviderId;

  @override
  void initState() {
    _children.add(HomePage());
    _children.add(ListPage());
    // _children.add(GroceryCartTabView());
    // _children.add(OrderHistoryTabView());
    // _children.add(COVIDPage());
    // _children.add(GroceryProfileTabView());

    _appBars.add(PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: Text(''),
    ));
    _appBars.add(_buildAppBar());
    _appBars.add(_buildAppBarOne("Your Cart"));
    // _appBars.add(_buildAppBarOne("Your Orders"));
    // _appBars.add(_buildAppBarOne("Corona News"));
    // _appBars.add(_buildAppBarOne("You"));

    super.initState();
    // userDataProvider.getDataFromStorage();
    // getDataFromStorage();
  }

  Future<bool> _onWillPop() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(right: 16.0),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        bottomLeft: Radius.circular(75),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Alert!",
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Text("Do you want to exit?"),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text("No"),
                                  color: Colors.green,
                                  colorBrightness: Brightness.dark,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Yes"),
                                  color: Colors.red,
                                  colorBrightness: Brightness.dark,
                                  onPressed: () {
                                    logout();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: _appBars[_currentIndex],
        body: _children[_currentIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            child: Card(
              child: Container(
                child: TextField(
                  onChanged: (text) {},
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      hintText: "Search products",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search))),
                ),
              ),
            ),
          ),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Image.asset('assets/images/IA.png'),
          // ),
        ),
      ),
    );
  }

  Widget _buildAppBarOne(String title) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title:
          //  title=='Your Orders' ?Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text(
          //         'Orders',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       IconButton(icon: Icon(Icons.refresh), onPressed: () {
          //         userDataProvider.getorders();
          //       },)
          //     ],
          //   )
          // :
          Row(
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.black)),
          if (title == 'Your Orders') Spacer(),
          if (title == 'Your Orders')
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.green,
              ),
              onPressed: () {
                // getOrdersfromDb(userID);
              },
            )
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), title: Text("Dashboard")),
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.shopping_cart), title: Text("Cart")),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.history), title: Text("Orders")),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.dashboard), title: Text("News")),
        // BottomNavigationBarItem(
        // icon: Icon(Icons.person_outline), title: Text('You')),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  logout() {
    // userDataProvider.logOut();
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => RegisterUser()),
    //     ModalRoute.withName("/register"));
  }
}
