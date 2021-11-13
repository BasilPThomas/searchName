import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/searchPage.dart';
import 'package:search/user_model.dart';
import 'detailSearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(),),
      ],
      child: MaterialApp(
        title: 'Search Page',
        routes: {
          MyHomePage.routeName :(ctx) =>MyHomePage(),
          DetailSearchPage.routeName :(ctx) =>DetailSearchPage(),
        },
      ),
    );
  }
}


