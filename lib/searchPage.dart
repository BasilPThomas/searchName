import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'detailSearchPage.dart';
import 'user_model.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = "/MyHomePage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userEditTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final userAttr = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search People")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          padding: EdgeInsets.all(4),
          children: <Widget>[
            DropdownSearch<UserModel>.multiSelection(
              searchFieldProps: TextFieldProps(
                controller: _userEditTextController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _userEditTextController.clear();
                    },
                  ),
                ),
              ),
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 700,
              isFilteredOnline: true,
              showClearButton: true,
              showSelectedItems: true,
              showSearchBox: true,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onFind: (String? filter) => getData(filter),
              onChanged: (data) {
                print(data);
              },
              dropdownBuilder: _customDropDownExampleMultiSelection,
              popupItemBuilder: _customPopupItemBuilderExample,
              popupSafeArea: PopupSafeAreaProps(top: true, bottom: true),
              scrollbarProps: ScrollbarProps(
                isAlwaysShown: true,
                thickness: 7,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(
      BuildContext context, List<UserModel?> selectedItems) {
    if (selectedItems.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("Search Name"),
      );
    }
    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(e?.title ?? ''),

            ),
          ),
        );
      }).toList(),
    );
  }


  Widget _customPopupItemBuilderExample(
      BuildContext context, UserModel? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.title ?? ''),
        subtitle: Text(item?.description.toString() ?? ''),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item!.profileUrl ?? ''),
        ),
        onTap: (){
          Navigator.of(context).pushNamed(
              DetailSearchPage.routeName,
              arguments: UserModel.id,
          );
        },
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    var response = await Dio().get(
      "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=Sachin+T&gpslimit=10",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}
