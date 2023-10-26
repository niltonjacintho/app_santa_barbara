import 'package:app2021/app/controllers/auth_controller.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/artigos/controllers/artigos_controller.dart';
import 'package:app2021/app/modules/vela/views/vela_acesa_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //use 'controller' variable to access controller
  ArtigosController artigosController = Get.put(ArtigosController());
  HomeController controller = Get.put(HomeController());
  UtilsController utils = Get.put(UtilsController());
  AuthController authController = Get.put(AuthController());
  // VelavirtualController velavirtual = Modular.get();
  final _scrollController = FixedExtentScrollController();
  int _index = 0;

  @override
  // ignore: override_on_non_overriding_member
  void initState() {
    //super();
    //  velavirtual.getVelasAcesas(authController.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    controller.fillMenu();
    return WillPopScope(
      onWillPop: () async {
        UtilsController().showLongToast(
            'Muito obrigado por ter vindo! \nVolte sempre!\bA casa é sua!');
        SystemNavigator.pop();
        //  return Future<true>();
        return false;
      },
      child: new Scaffold(
        backgroundColor: utils.corFundoAvisos,
        // appBar: new AppBar(
        //   title: new Text('Sua Paróquia'),
        //   backgroundColor: Colors.red[900],
        // ),
        floatingActionButton: Opacity(
          opacity: controller.qtdVelasAcesas.value < 1
              ? 01
              : 1, // visible if showShould is true
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.to(VelaAcesaView());
            },
            label: Text(
                'você possui ${controller.velasAcesas.length} vela(s) acesas'),
            icon: Icon(Icons.thumb_up),
            backgroundColor: Colors.pink,
          ),
        ),
        //  ),
        //drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 30, right: 30),
          child: GestureDetector(
            child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: (value) => {
                //   setState(() {
                _index = value,
                controller.opcaoMenu.value = value,

                print('print selected $_index'),
                //  })
              },
              controller: _scrollController,
              itemExtent: 200,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: controller.listaMenu.length,
                builder: (context, index) => Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: index == controller.opcaoMenu.value
                          ? Colors.red[900]
                          : Colors.white,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Image.asset(
                          controller.listaMenu[index].image,
                          fit: BoxFit.fill,
                        ), // NetworkImage('https://imagens.canaltech.com.br/empresas/690.400.jpg'),
                      ),

                      //Image.asset(controller.listaMenu[index].image),
                      title: Text(
                        controller.listaMenu[index].titulo,
                        style: TextStyle(
                          fontSize: 36,
                          color: index == controller.opcaoMenu.value
                              ? Colors.white
                              : Colors.blue,
                        ),
                      ),
                      subtitle: Text(
                        controller.listaMenu[index].subtitulo,
                        style: TextStyle(
                          color: index == controller.opcaoMenu.value
                              ? Colors.white
                              : Colors.blue,
                          fontSize: 22,
                        ),
                      ),
                      onTap: () => {
                        print('entra 1'),
                      },
                    ),
                  ),
                ),
              ),
            ),
            onTap: () => {
              print('vai chamar'),
              Get.toNamed(controller.listaMenu[_index].destino),
            },
          ),
        ),
      ),
    );
  }
}
