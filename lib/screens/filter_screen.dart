import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const ROUTE_NAME = '/filters';
  // ignore: prefer_typing_uninitialized_variables
  final void Function(Map<String, bool>) saveFilters;
  final Map<String, bool> filters;

  const FilterScreen(this.filters, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.filters['gluten'] ?? false;
    _vegetarian = widget.filters['vegetarian'] ?? false;
    _lactoseFree = widget.filters['lactose'] ?? false;
    _vegan = widget.filters['vegan'] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filter'),
        actions: [
          IconButton(
            onPressed: () {
              final filteredData = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(filteredData);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile(
                title: const Text('Gluten Free'),
                value: _glutenFree,
                subtitle: const Text('Only include gluten free meals'),
                onChanged: (newValue) {
                  setState(
                    () {
                      _glutenFree = newValue;
                    },
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Lactose Free'),
                value: _lactoseFree,
                subtitle: const Text('Only include lactose free meals'),
                onChanged: (newValue) {
                  setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Vegetarian'),
                value: _vegetarian,
                subtitle: const Text('Only include vegetarian meals'),
                onChanged: (newValue) {
                  setState(
                    () {
                      _vegetarian = newValue;
                    },
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Vegan'),
                value: _vegan,
                subtitle: const Text('Only include Vegan meals'),
                onChanged: (newValue) {
                  setState(
                    () {
                      _vegan = newValue;
                    },
                  );
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
