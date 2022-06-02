import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_items.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/category_meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('did change dependencies');
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle.toString()),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            var selectedCategoryMeal = displayedMeals[index];
            return MealItems(
              id: selectedCategoryMeal.id,
              title: selectedCategoryMeal.title,
              imageUrl: selectedCategoryMeal.imageUrl,
              duration: selectedCategoryMeal.duration,
              complexity: selectedCategoryMeal.complexity,
              affordability: selectedCategoryMeal.affordability,
              removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
