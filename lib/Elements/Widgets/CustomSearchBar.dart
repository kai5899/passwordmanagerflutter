import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/core/Colors/Colours.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  final MainController _mainController = Get.put(MainController());

  final RootController _rootController  =Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: context.width*0.75,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: _rootController.secondaryColor.value.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: _controller,
        cursorColor: _rootController.primaryColor.value,
        style:  TextStyle(
          color: _rootController.primaryColor.value,
        ),
        decoration:  InputDecoration(
          labelText: 'Search',
          // hintText: 'Enter your search query...',

          prefixIcon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: _rootController.primaryColor.value,
          ),
          labelStyle: TextStyle(
            color: _rootController.primaryColor.value,
            fontFamily: 'ocr-a',
            fontSize: 13,
          ),

          border: InputBorder.none,
        ),

        onChanged: (query) {


          if(query.isEmpty){
            _mainController.filterMode.value=1;
          }else{
            if(_mainController.filterMode.value!=0){
              _mainController.filterMode.value=0;
            }
            _mainController.filterQuery.value = query;

          }

          // Handle search logic here
          // You can use the query to filter your data
        },
      ),
    );
  }
}
