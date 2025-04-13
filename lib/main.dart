import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas2/screens/crud_screen.dart';
import 'models/recipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 always do this before async code (GPT HELP)

  // init Hive
  await Hive.initFlutter();

  Hive.registerAdapter(
    RecipeAdapter(),
  ); // 👈 register the adapter for your model (GPT HELP)

  // open box
  await Hive.openBox<Recipe>('recipes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: RecipeStaticPage(),
    );
  }
}
