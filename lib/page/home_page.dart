import 'package:flutter/material.dart';
import 'package:pratice_project/models/recipe.dart';
import 'package:pratice_project/page/recipe_page.dart';
import 'package:pratice_project/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe Book",
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _recipeTypeButtons(),
            _recipeList(),
          ],
        ));
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'Snack ';
                  });
                },
                child: const Text(" 🍟Snack")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'Lunch';
                  });
                },
                child: const Text("🥗 Lunch")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'Dinner';
                  });
                },
                child: const Text(" 🥪Dinner")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'Tiffen';
                  });
                },
                child: const Text("🥗 Tiffen")),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getRecipes(_mealTypeFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Unable to load data"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RecipePage(recipe: recipe);
                        }));
                      },
                      contentPadding: const EdgeInsets.only(top: 20.0),
                      isThreeLine: true,
                      subtitle: Text(
                          "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}"),
                      leading: Image.network(recipe.image),
                      title: Text(
                        recipe.name,
                      ),
                      trailing: Text(
                        "${recipe.rating.toString()} ⭐",
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  });
            }));
  }
}
