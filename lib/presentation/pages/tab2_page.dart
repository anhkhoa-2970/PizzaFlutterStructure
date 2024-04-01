import 'package:flutter/material.dart';
import 'package:testxxxx/config/app_router.dart';
import 'package:testxxxx/config/app_routes.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          runtimeType.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        }, icon: const Icon(Icons.menu, color: Colors.white,)),
      ),
      body: Container(
        color: Colors.green,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              router.pushNamed(AppRoutes.tab2Details.name);
            },
            style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text("Go to Tab2DetailPage", style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}

class Tab2DetailPage extends StatelessWidget {
  const Tab2DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(runtimeType.toString(), style: const TextStyle(color: Colors.white)),
        leading: IconButton(
            onPressed: () {
              router.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Text(runtimeType.toString(), style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
