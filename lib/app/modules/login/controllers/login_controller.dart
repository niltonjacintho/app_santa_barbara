import 'package:app2021/app/controllers/auth_controller.dart';
import 'package:app2021/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  bool _loading = false;
  AuthController authController = Get.put(AuthController());

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  void loginWithGoole() async {
    try {
      _loading = true;
      print(1);
      await authController.google_signIn(); // .loginWithGoogle();
      print(2);
      _loading = false;
      print(authController.user);
      if (authController.user != null) {
        Get.to(() => HomeView());
      } else {
        print('erro de login');
      }
      //  Modular.to.pushNamed('/home');
    } catch (e) {
      _loading = false;
    }
  }

  void loginWithFAcebook() {}
}
