import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/Views/root.dart';

class FirstTimeLoginController extends GetxController {
  RxString combo = ''.obs;
  final GetStorage _localStore = GetStorage();

  void addToCombo(String i) {
    if (i != '-1') {
      if (combo.value.length < 5) {
        combo.value += i;
      }
    } else {
      if (combo.value.isNotEmpty) {
        combo.value = combo.value.substring(0, combo.value.length - 1);
      }
    }
  }

  void saveAndContinue(){
    _localStore.write('passcode', combo.value);
    print(combo.value);
    Get.offAll(()=> Root());
  }
}
