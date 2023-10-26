import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:app2021/app/modules/memorial/controllers/memorial_controller.dart';

class MemorialView extends GetView<MemorialController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MemorialView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MemorialView is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  