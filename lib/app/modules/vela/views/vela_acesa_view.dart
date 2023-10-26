import 'package:app2021/app/controllers/styles_controller.dart';
import 'package:app2021/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(VelaAcesaView());

class VelaAcesaView extends StatefulWidget {
  @override
  _VelaAcesaViewState createState() => _VelaAcesaViewState();
}

class _VelaAcesaViewState extends State<VelaAcesaView>
    with TickerProviderStateMixin {
  StylesController stylesController = Get.put(StylesController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow[900],
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(() => HomeView());
          },
          child: Icon(Icons.home)),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Vela2.gif"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Vela Acesa",
                style: stylesController.titulo,
              ),
              Text(
                "Sua vela vai ficar acesa por 4 horas ggfd fdg fd",
                style: stylesController.corpo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
