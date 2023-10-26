import 'package:app2021/app/modules/memorial/views/memorial_view.dart';
import 'package:app2021/app/modules/memorial/bindings/memorial_binding.dart';
import 'package:app2021/app/modules/oracoes/views/oracoes_view.dart';
import 'package:app2021/app/modules/oracoes/bindings/oracoes_binding.dart';
import 'package:app2021/app/modules/paroquias/views/paroquias_view.dart';
import 'package:app2021/app/modules/paroquias/bindings/paroquias_binding.dart';
import 'package:app2021/app/modules/quiz/views/quiz_view.dart';
import 'package:app2021/app/modules/quiz/bindings/quiz_binding.dart';
import 'package:app2021/app/modules/vela/views/vela_acesa_view.dart';
import 'package:app2021/app/modules/vela/views/vela_view.dart';
import 'package:app2021/app/modules/vela/bindings/vela_binding.dart';
import 'package:app2021/app/modules/parocos/views/parocos_view.dart';
import 'package:app2021/app/modules/parocos/bindings/parocos_binding.dart';
import 'package:app2021/app/modules/artigos/views/artigos_view.dart';
import 'package:app2021/app/modules/artigos/bindings/artigos_binding.dart';
import 'package:app2021/app/modules/login/views/login_view.dart';
import 'package:app2021/app/modules/login/bindings/login_binding.dart';
import 'package:app2021/app/modules/home/views/home_view.dart';
import 'package:app2021/app/modules/home/bindings/home_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ARTIGOS,
      page: () => ArtigosView(),
      binding: ArtigosBinding(),
    ),
    GetPage(
      name: Routes.PAROCOS,
      page: () => ParocosView(),
      binding: ParocosBinding(),
    ),
    GetPage(
      name: Routes.VELA,
      page: () => VelaView(),
      binding: VelaBinding(),
    ),
    GetPage(
      name: Routes.VELAACESA,
      page: () => VelaAcesaView(),
      binding: VelaBinding(),
    ),
    GetPage(
      name: Routes.QUIZ,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: Routes.PAROQUIAS,
      page: () => ParoquiasView(),
      binding: ParoquiasBinding(),
    ),
    GetPage(
      name: Routes.ORACOES, 
      page:()=> OracoesView(), 
      binding: OracoesBinding(),
    ),
    GetPage(
      name: Routes.MEMORIAL, 
      page:()=> MemorialView(), 
      binding: MemorialBinding(),
    ),
  ];
}