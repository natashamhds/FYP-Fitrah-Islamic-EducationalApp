// import 'package:fitrah_app/config/ColorScheme.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:flutter/material.dart';
import 'navpages/Home Page/home_page.dart';
import 'navpages/Marks Page/bar_item_page.dart';
import 'navpages/Profile Page/my_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const BarItemPage(),
    const MyPage()
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: darkBlue,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.apps)),
        BottomNavigationBarItem(label: 'Bar', icon: Icon(Icons.bar_chart_sharp)),
        BottomNavigationBarItem(label: 'My', icon: Icon(Icons.person)),
      ],
      ),
    );
  }
}
