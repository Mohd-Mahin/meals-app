import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/screens/bottom_tab_screen.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meal_details_screen.dart';
import './models/meal.dart';
// import 'package:meals/screens/tab_screen.dart';

void main() => runApp(MealApp());

class MealApp extends StatefulWidget {
  const MealApp({Key? key}) : super(key: key);

  @override
  State<MealApp> createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeal = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealApp',
      theme: ThemeData(
        appBarTheme: ThemeData.light()
            .appBarTheme
            .copyWith(backgroundColor: Colors.pink),
        primarySwatch: Colors.pink,
        colorScheme: ThemeData.light().colorScheme.copyWith(
              secondary: Colors.amber,
            ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline1: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
      ),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => const BottomTabScreen(),
        CategoryMealsScreen.ROUTE_NAME: (ctx) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailsScreen.ROUTE_NAME: (ctx) => MealDetailsScreen(),
        FilterScreen.ROUTE_NAME: (ctx) => FilterScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
    );
  }
}
