import 'package:Edudito/screens/account_page.dart';
import 'package:Edudito/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _currentIdx;
  Widget _body;

  @override
  void initState() {
    super.initState();
    _currentIdx = 0;
    _body = HomePage();
  }

  void changePage(int idx) {
    setState(() {
      _currentIdx = idx;
      switch (_currentIdx) {
        case 0:
          _body = HomePage();
          break;
        case 1:

          /// [todo] add add effect.
          print('Add button pressed');
          break;
        case 2:
          _body = AccountPage();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
        currentIndex: _currentIdx,
        onTap: changePage,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              width: _currentIdx == 0 ? 23 : 20,
              color: _currentIdx == 0 ? Theme.of(context).accentColor : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            label: 'Add environment',
            icon: Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Color(0xffF8DE44),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 40,
                      offset: Offset(0, 15)),
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 13,
                      offset: Offset(0, 3))
                ],
              ),
              child: new Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/account.svg',
              width: _currentIdx == 2 ? 23 : 20,
              color: _currentIdx == 2 ? Theme.of(context).accentColor : null,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
