// search_page.dart

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Center(
        child: Text('Results for "$query"'),
      ),
    );
  }
}

class SearchItem {
  final String title;
  final Widget page;

  SearchItem(this.title, this.page);
}
