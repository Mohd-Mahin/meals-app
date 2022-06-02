import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favourite_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  final List<Map<String, Object>> pages = [
    {'page': CategoriesScreen(), 'title': 'Category'},
    {'page': const FavouriteScreen(), 'title': 'Your Favourite'}
  ];
  int pageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[pageIndex]['title'] as String),
      ),
      body: pages[pageIndex]['page'] as Widget,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: pageIndex,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite')
        ],
      ),
    );
  }
}
