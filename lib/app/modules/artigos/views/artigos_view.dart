import 'package:app2021/app/controllers/styles_controller.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/artigos/views/artigo_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/artigos/controllers/artigos_controller.dart';

class ArtigosView extends StatefulWidget {
  final String title;
  const ArtigosView({required Key key, this.title = "Login"}) : super(key: key);

  @override
  _ArtigosViewState createState() => _ArtigosViewState();
}

class _ArtigosViewState extends State<ArtigosView> {
  ArtigosController controller = Get.put(ArtigosController());
  StylesController stylesController = Get.put(StylesController());
  PageController _pageController = PageController();
  UtilsController _utilsController = Get.put(UtilsController());
  late Stream<QuerySnapshot> streamArtigos;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> categorias = controller.getCategoryList();
    //controller.getArtigosList('avisos');
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/fundo_cruz.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categorias.length - 1,
                        itemBuilder: (BuildContext context, int index) {
                          //children: <Widget>[
                          return Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 150, height: 200),
                              child: ElevatedButton(
                                child: Center(child: categorias[index].child),
                                style: ElevatedButton.styleFrom(
                                  // padding: EdgeInsets.all(20),
                                  primary: Colors.amber[50],
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                onPressed: () {
                                  // setState(() async {
                                  controller.menuSelecionado =
                                      categorias[index].value;
                                  _pageController.animateToPage(
                                      categorias[index].value["id"],
                                      duration: Duration(seconds: 1),
                                      curve: Curves.decelerate);
                                  print('grupo ${controller.grupo.value}');
                                  // });
                                  print('Pressed');
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Container(
                              color: Colors.transparent,
                              child: Center(child: lista(context, "avisos")),
                            ),
                          ),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "eventos")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "noticias")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "parocos")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "pessoas")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "paroquia")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "duvidas")),
                          Container(
                              height: 200,
                              color: Colors.transparent,
                              child: lista(context, "horários")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //  ),
        ),
      ],
    );
  }

  Widget lista(BuildContext context, String grupo) {
    return
        // Expanded(
        //   child:
        StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('artigos')
          .where('grupo', isEqualTo: grupo)
          .snapshots(), //  streamArtigos, // myStream,
      builder: (context,AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((snapshot.data.docs.length == 0)) {
          return Center(
            child: Text('não encontrei '),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot doc = snapshot.data.docs[index];
              return Container(
                color: Colors.transparent,
                //child: Expanded(
                child: Column(children: [
                  GestureDetector(
                    onTap: () => {
                      controller.docAtivo =
                          controller.convertSnapShotToArtigos(doc),
                      Get.to(() => ArtigoDetailView())
                    },
                    child: Card(
                      elevation: 20,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: doc.get("imagem") != ""
                                ? Image.network(
                                    doc.get("imagem"),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                  )
                                : Text(''),
                            height: doc.get("imagem") != "" ? 300 : 10,
                            width: doc.get("imagem") != "" ? 400 : 10,
                          ),
                          Text(
                            doc.get("titulo"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              doc.get("conteudo"),
                              style: TextStyle(
                                  fontSize: _utilsController.tamanhoFonte.value,
                                  color: Colors.white),
                              strutStyle: StrutStyle(fontSize: 13),
                            ),
                          ),
                          Divider(
                            color: Colors.red,
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            });
      },
    );
  }
}

// (
//         children: snapshot.data.docs.map((document) => {
//           return  Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width / 1.2,
//               height: MediaQuery.of(context).size.height / 6,
//               child: Text("Title: " + document['title']),
//             ),
//         )
//         }).toList())

// return Container(
//   height: 20, //double.infinity,
//   child: SizedBox(
//     height: 10,
//     child: Card(
//       elevation: 10,
//       color: Colors.red[900], // Colors.white38,
//       // decoration: new BoxDecoration(
//       //   border: new Border.all(color: Colors.grey[500]),
//       //   color: Colors.white38,
//       // ),
//       child: Text('11111'),
//     ),
//   ),
// );

//   child: Column(
//     children: [
//       // Image.asset(
//       //   "assets/images/fundo_cruz.jpg",
//       //   height: 160, // MediaQuery.of(context).size.height,
//       //   width: MediaQuery.of(context).size.width,
//       //   fit: BoxFit.cover,
//       // ),
//       //   ListTile(
//       //  //   shape: ShapeDecoration(shape: shape)
//       //     title: Text(snapshot.data.docs[0]['titulo']),
//       //     subtitle: Text('subtitulo'),
//       //   ),
//       // SizedBox(
//       //   height: 10,
//       // )
//     ],
//   ),
// );
//   },
//   ),
// );
// }

//  Widget menu() {
//   return BoomMenu(
//     animatedIcon: AnimatedIcons.menu_close,
//     animatedIconTheme: IconThemeData(size: 22.0),
//     //child: Icon(Icons.add),
//     onOpen: () => print('OPENING DIAL'),
//     onClose: () => print('DIAL CLOSED'),
//     scrollVisible: true,
//     overlayColor: Colors.black,
//     overlayOpacity: 0.7,
//     children: [
//       MenuItem(
//         child: Icon(Icons.new_releases_sharp, size: 40, color: Colors.black),
//         title: "Avisos",
//         titleColor: Colors.white,
//         subtitle: "Veja aqui os avisos paroquiais de nossa paróquia",
//         subTitleColor: Colors.white,
//         backgroundColor: Colors.deepOrange,
//         onTap: () => _pageController.animateToPage(0,
//             duration: Duration(seconds: 1), curve: Curves.decelerate),
//       ),
//       MenuItem(
//         child: Icon(Icons.brush, color: Colors.black),
//         title: "Profiles",
//         titleColor: Colors.white,
//         subtitle: "You Can View the Noel Profile",
//         subTitleColor: Colors.white,
//         backgroundColor: Colors.green,
//         onTap: () => _pageController.animateToPage(1,
//             duration: Duration(seconds: 1), curve: Curves.decelerate),
//       ),
//       MenuItem(
//         child: Icon(Icons.keyboard_voice, color: Colors.black),
//         title: "Profile",
//         titleColor: Colors.white,
//         subtitle: "You Can View the Noel Profile",
//         subTitleColor: Colors.white,
//         backgroundColor: Colors.blue,
//         onTap: () => print('THIRD CHILD'),
//       ),
//       MenuItem(
//         child: Icon(Icons.ac_unit, color: Colors.black),
//         title: "Profiles",
//         titleColor: Colors.white,
//         subtitle: "You Can View the Noel Profile",
//         subTitleColor: Colors.white,
//         backgroundColor: Colors.blue,
//         onTap: () => print('FOURTH CHILD'),
//       )
//     ],
//   );
// }
//}
