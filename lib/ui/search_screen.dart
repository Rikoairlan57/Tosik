import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search_screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        children: const [
          Center(
            child: Text("Search Screen"),
          ),
        ],
      ),
    );
  }
}
