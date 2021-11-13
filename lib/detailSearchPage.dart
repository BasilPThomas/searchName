import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/user_model.dart';

class DetailSearchPage extends StatefulWidget {
  static const routeName = "/MyHomePage";

  @override
  _DetailSearchPageState createState() => _DetailSearchPageState();
}

class _DetailSearchPageState extends State<DetailSearchPage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserModel>(context);
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    final userAttr = userData.findById(userId);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userAttr.profileUrl),
              ),
            ),
            Center(
              child: Text(
                userAttr.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              userAttr.description,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}