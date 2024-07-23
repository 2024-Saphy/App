import 'package:flutter/material.dart';
import 'package:saphy/widgets/bottom_nav_bar.dart';
import 'package:saphy/screens/main/main_screen.dart';
import 'package:saphy/screens/products/liked_list_page.dart';
import 'package:saphy/screens/search/search_screen.dart';
import 'package:saphy/screens/mypage/mypage.dart';

// void main() {
//   // async {
//   // await dotenv.load(fileName: 'assets/config/.env');
//   runApp(const ScreenController());
// }

class ScreenController extends StatefulWidget {
  const ScreenController({super.key});

  @override
  ScreenControllerState createState() => ScreenControllerState();
}

class ScreenControllerState extends State<ScreenController> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const SearchScreen(),
    const LikedListPage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Saphy",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _getSelectedWidget(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getSelectedWidget(int index) {
    return _widgetOptions[index];
  }
}
