import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Elements/Widgets/AddWidgets/AddCardWidget.dart';
import 'package:password_manager/Elements/Widgets/AddWidgets/AddCategoryWidget.dart';
import 'package:password_manager/Elements/Widgets/AddWidgets/AddPasswordWidget.dart';
import 'package:password_manager/Elements/Widgets/Swiper.dart';
import 'package:password_manager/Views/Home/HomeScreenBody.dart';
import 'package:password_manager/Views/Home/Pages/DetailPasswordView.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MainController _controller = Get.put(MainController());

  final RootController _rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        child: SlidingUpPanel(
          panelBuilder: () {
            return Material(
              color: Colors.transparent,
              child: buildPanel(),
            );
          },
          body: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: _rootController.isDarkMode.value
                  ? const Color(0xFF333333)
                  : Colors.white,
              title: AnimatedSwitcher(
                duration: 100.ms,
                child: Text(
                  key: ValueKey<bool>(_rootController.isProfileVisible.value),
                  !_rootController.isProfileVisible.value
                      ? "Hello , ${_rootController.userUsername.value} !"
                      : "Profile & Settings",
                  style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                      color: _rootController.isDarkMode.value
                          ? null
                          : _rootController.primaryColor.value),
                ),
              ),
              actions: [
                Icon(
                  FontAwesomeIcons.solidBell,
                  color: _rootController.isDarkMode.value
                      ? null
                      : _rootController.primaryColor.value,
                  // color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      _rootController.toggleProfileVisibility();
                    },
                    child: AnimatedIcon(
                      color: _rootController.isDarkMode.value
                          ? null
                          : _rootController.primaryColor.value,
                      icon: AnimatedIcons.menu_close,
                      progress: _rootController.animationIcon,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
            // backgroundColor: Colors.white,
            body: SwipeDetector(
              onSwipeDown: () {

                _rootController.toggleProfileVisibility();
              },
              onSwipeUp: () {
                //check if shown before ; todo
                _rootController.toggleProfileVisibility();
              },
              child: const HomeScreenBody(),
            ),
            floatingActionButton:buildFloatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              iconSize: 32,
              icons: const [
                FontAwesomeIcons.shield,
                FontAwesomeIcons.solidCreditCard,
                FontAwesomeIcons.keycdn,
                FontAwesomeIcons.lock,
              ],
              activeIndex: _controller.currentTab.value,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              borderColor: _rootController.isDarkMode.value
                  ? Colors.white
                  : _rootController.primaryColor.value,
              backgroundColor: _rootController.isDarkMode.value
                  ? const Color(0xFF333333)
                  : _rootController.primaryColor.value,
              inactiveColor: Colors.white70,
              activeColor: _rootController.secondaryColor.value,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) {
                _controller.changeTab(index);
              },
              //other params
            ),
          ),
          minHeight: 0,
          maxHeight: _controller.addMode.value == 0
              ? context.height * 0.75
              : context.height * 0.90,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
          backdropColor: _rootController.secondaryColor.value,
          backdropEnabled: true,
          backdropOpacity: 0.15,

          controller: _controller.panelController,
          // snapPoint: .5,
          header: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 50,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          if (_controller.panelController.isPanelClosed) {
            return Future(() => true);
          } else {
            _controller.panelController.close();
            return Future(() => false);
          }
        },
      ),
    );
  }

  Widget buildPanel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        color: Get.theme.colorScheme.background,
      ),
      child: _controller.addMode.value == 0
          ? const AddCategoryForm()
          : _controller.addMode.value == 1
              ? const AddPasswordForm()
              : _controller.addMode.value == 2
                  ? const AddCardForm()
                  : const DetailPasswordView(),
    );
  }

  Widget buildFloatingActionButton() {

    bool isTabValueTwo = _controller.currentTab.value == 2;

    return ClipOval(
      child: Material(
        color: _rootController.secondaryColor.value, // Background color
        child: InkWell(
          onTap: ()  {
            if (_rootController.isProfileVisible.value) {
              _rootController.toggleProfileVisibility();
            }
            if (_controller.currentTab.value == 2) {
              _controller.generatePassword();
            } else {
              _controller
                  .changeAddMode(_controller.currentTab.value == 0 ? 1 : 2);
              _controller.panelController.open();
            }
          },
          child: AnimatedContainer(
            duration: 500.ms,
            width: isTabValueTwo ? 70.0 : 56.0, // Adjust size accordingly
            height: isTabValueTwo ? 70.0 : 56.0, // Adjust size accordingly
            child: Center(
              child: Icon(
                isTabValueTwo
                    ? FontAwesomeIcons.arrowsRotate
                    : FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
