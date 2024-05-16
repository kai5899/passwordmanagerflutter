import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Elements/Widgets/SquareButton.dart';
import 'package:password_manager/Views/Home/Pages/CardsViewPage.dart';
import 'package:password_manager/Views/Home/Pages/HomeView.dart';
import 'package:password_manager/Views/Home/Pages/PasswordGeneratorView.dart';
import 'package:password_manager/Views/Home/Pages/SecretVaultView.dart';
import 'package:password_manager/Views/Home/Pages/SettingsView.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  final MainController _mainController = Get.put(MainController());
  final RootController _rootController = Get.put(RootController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _rootController.isProfileVisible.value
                  ? FadeTransition(
                      opacity: _rootController.animationIcon,
                      child: SlideTransition(
                          position: _rootController.slideAnimation,
                          child: ProfilePanel()),
                    )
                  : const SizedBox.shrink(),
              FadeTransition(opacity: _rootController.fadeAnimation,child: SlideTransition(
                position: _rootController.slideAnimationForBody,
                child: SizedBox(
                  width: context.width,
                  height: context.height,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _mainController.pageController,
                    children: const [
                      HomeViewPage(),
                      CardsViewPage(),
                      PasswordGeneratorView(),
                      SecretVaultView(),
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ));
  }
}

class ProfilePanel extends StatelessWidget {
  final RootController rootController = Get.put(RootController());

  ProfilePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Material(
      elevation: 1,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      child: AnimatedContainer(
          width: context.width,
          height: context.height * 0.8,
          padding: const EdgeInsets.all(20),
          decoration:  BoxDecoration(
            color:rootController.isDarkMode.value ?const Color(0xFF333333) : Colors.white ,
            borderRadius:const  BorderRadius.vertical(bottom: Radius.circular(36)),
          ),
          duration: 1.ms,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontFamily: 'ocr-a',
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        rootController.userUsername.value,
                        style: const TextStyle(fontSize: 28),
                      ),
                      subtitle: const Text("username"),
                      trailing: SquareButton(
                        onPressed: () {
                          rootController.setUsername(context);
                        },
                      ),
                    ),
                    ListTile(
                      subtitle: Text(
                        rootController.userEmail.value,
                        style: const TextStyle(fontSize: 18),
                      ),
                      title: const Text("email"),
                      trailing: SquareButton(
                        onPressed: () {
                          rootController.setEmail(context);
                        },
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 24,
                    ),
                  ),
                ),
                const Expanded(child: SettingsView(),),
                Center(
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}


