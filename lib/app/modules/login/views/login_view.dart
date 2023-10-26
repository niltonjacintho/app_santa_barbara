import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(179, 45, 0, 1.0),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/santabarbara.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 200,
                left: 30,
                right: 30),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  // elevation: 0.0,
                  child: ListTile(
                    leading: Image.asset('assets/images/google.png'),
                    title: Text(
                      'Google Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    //    trailing: Icon(Icons.more_vert),
                  ),
                  // shape: new RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(30.0)),
                  // padding: EdgeInsets.only(
                  //     top: 7.0, bottom: 7.0, right: 7.0, left: 7.0),
                  onPressed: () => {
                    controller.loginWithGoole(),
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  // elevation: 0.0,
                  child: ListTile(
                    leading: Image.asset('assets/images/facebook.png'),
                    title: Text(
                      'Facebook Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  // shape: new RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(30.0)),
                  // padding: EdgeInsets.only(
                  //     top: 7.0, bottom: 7.0, right: 7.0, left: 7.0),
                  onPressed: () async => {
                    // desativado mas funcionando     remedios_controller.montarListaRemedios(),
                    // await remedios_controller.gravarRemedios(),
                    controller.loginWithFAcebook(),
                  },
                ),
              ],
            ),
            //  ),
          ),
        ),
      ),
    );
  }
}
