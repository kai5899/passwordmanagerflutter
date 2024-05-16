import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Elements/Widgets/CategoryHomeWidget.dart';
import 'package:password_manager/Elements/Widgets/CustomSearchBar.dart';
import 'package:get/get.dart';
import 'package:password_manager/Models/PasswordModel.dart';
import 'package:password_manager/Models/CategoryModel.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  final MainController _mainController = Get.put(MainController());
  final RootController _rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //search bar
        const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: CustomSearchBar()),
              // SizedBox(
              //   width: 15,
              // ),
              // FilterButton(),
            ],
          ),
        ),

        //filtering on/off
        Obx(
          () => Expanded(
            child: _mainController.filterMode.value == 0
                ?
                //filter on
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Searched passwords",
                              style: TextStyle(
                                fontFamily: 'ocr-a',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //list building
                      Obx(() => Expanded(
                            child: _mainController.passwords.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No passwords found",
                                      style: TextStyle(
                                          fontFamily: 'ocr-a',
                                          fontSize: 24,
                                          color: Colours.lokiBeige),
                                    ),
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Password p = _mainController
                                          .filterPassword()[index];
                                      Category c = _mainController.categories
                                          .firstWhere((element) =>
                                              element.id == p.categoryId);
                                      return buildPassword(c, p,context);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 14,
                                        ),
                                    itemCount:
                                        _mainController.filterPasswordLength()),
                          ))
                    ],
                  )
                //filter off
                : Column (
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //categories
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Categories",
                              style: TextStyle(
                                  fontFamily: 'ocr-a',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                _mainController.changeAddMode(0);
                                _mainController.panelController.open();
                              },
                              child:  Icon(
                                Icons.control_point_duplicate,
                                color:_rootController.secondaryColor.value ,
                                size: 36,
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            color: Colors.transparent,
                            height: context.height * 0.125,
                            // width: context.width,
                            child: _mainController.categories.isEmpty
                                ? Center(
                                    child: InkWell(
                                      onTap: () {
                                        _mainController.changeAddMode(0);
                                        _mainController.panelController.open();
                                      },
                                      child: const Text(
                                        "Add some categories",
                                        style: TextStyle(
                                            fontFamily: 'ocr-a',
                                            fontSize: 24,),
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 10,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _mainController.categories.length,
                                    itemBuilder: (context, index) =>
                                        CategoryHomeWidget(
                                      category:
                                          _mainController.categories[index],
                                      index: index,
                                      onTap: () {
                                        _mainController.deleteCategory(
                                            context,
                                            _mainController
                                                .categories[index].id);
                                      },
                                    )
                                  ),
                          ),
                        ),
                      ),

                      //last added passwords
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Recently added",
                              style: TextStyle(
                                  fontFamily: 'ocr-a',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                //implement on tap
                              },
                              child:  Text(
                                "Show all",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ocr-a',
                                  color: _rootController.secondaryColor.value,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(() => Expanded(
                            child: _mainController.passwords.isEmpty
                                ?  const Center(
                                    child: Text(
                                      "No recent passwords",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'ocr-a',),
                                    ),
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      Password p =
                                          _mainController.passwords[index];
                                      Category c = _mainController.categories
                                          .firstWhere((element) =>
                                              element.id == p.categoryId);
                                      return buildPassword(c, p,context);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 14,
                                        ),
                                    itemCount:
                                        _mainController.passwords.length <=5 ? _mainController.passwords.length : 5),
                          ))
                    ],
                  ),
          ),
        )
      ],
    );
  }

  Widget buildPassword(Category c, Password p,myContext) {
    return Slidable(
        endActionPane:  ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                _mainController.updateSelectedPassword(p);
                _mainController.changeAddMode(3);
                _mainController.panelController.open();
              },
              backgroundColor: Get.theme.colorScheme.background ,
              foregroundColor: Get.isDarkMode ? Colors.white :Colors.black,
              icon: FontAwesomeIcons.pen,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) {
                _mainController.deletePassword(myContext ,p.id);
              },
              backgroundColor: Get.theme.colorScheme.background ,
              foregroundColor: Colors.red,
              icon: FontAwesomeIcons.trash,
              label: 'Delete',
            ),

          ],
        ),
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Color(ColorUtils.hexToInt(c.color)).withOpacity(1),
            borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          leading: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: 75,
            width: 75,
            child: Center(
              child: Icon(
                p.icon,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
          title: Text(
            p.site,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'ocr-a',),
          ),
          subtitle: Text(p.auth,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ocr-a',
              )),
          onTap: (){

          },
        ),
      ),
    ));
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.put(RootController()).primaryColor.value,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 55,
      width: 55,
      child: const Icon(
        FontAwesomeIcons.filter,
        color: Colors.white,
      ),
    );
  }
}
