import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../routes/router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder:
                (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      drawer: Drawer(child: Menu(),),
      body: SingleChildScrollView(
       child: Container(
         child: Padding(
           padding: const EdgeInsets.all(52.0),
           child: Column(
             // crossAxisAlignment: CrossAxisAlignment.center,
             // mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 child: ElevatedButton(onPressed: () {
                   Navigator.pushReplacementNamed(ctx, RoutePage.camera);
                 },
                     child: Text('상품 분석 및 추천', style: Theme.of(ctx).textTheme.titleMedium,)),
               ),
               SizedBox(height: 20),
               Container(
                 child: ElevatedButton(onPressed: () {
                   Navigator.pushReplacementNamed(ctx, RoutePage.receipt);
                 },
                     child: Text('영수증 분석', style: Theme.of(ctx).textTheme.titleMedium,)),
               ),
               SizedBox(height: 20),
             ],
           ),
         ),
       ),
      ),
    );
  }
}