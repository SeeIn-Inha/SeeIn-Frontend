import 'package:flutter/material.dart';
import '../routes/router.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          alignment: Alignment.center,
          height: 120,
          color: Theme.of(context).primaryColor,
          child: Text(
            style: Theme.of(context).textTheme.titleMedium,
            'SEE IN'
          ),
        ),  // Header Container
        ListTile(
          // Route to Home
          leading: Icon(
            Icons.home,
            size: 40,
          ),
          title: Text(
            style: Theme.of(context).textTheme.titleMedium,
            '홈'
          ),
          onTap: () {
            // 홈으로 이동
            Navigator.pushReplacementNamed(context, RoutePage.start);
          }
        ),
        ListTile(
          // Route to Camera
            leading: Icon(
              Icons.camera_alt_rounded,
              size: 40,
            ),
            title: Text(
                style: Theme.of(context).textTheme.titleMedium,
                '카메라'
            ),
            onTap: () {
              // 앱 핵심 기능 카메라 페이지로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(context, RoutePage.start);
            }
        ),
        // Border(
        //   top: BorderSide(
        //     color: Colors.black,
        //
        //   )
        // ),
        ListTile(
          // Route to Explain App??
            leading: Icon(
              Icons.menu_book_outlined,
              size: 40,
            ),
            title: Text(
                style: Theme.of(context).textTheme.titleMedium,
                '사용 설명'
            ),
            onTap: () {
              // 앱 사용 설명으로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(context, RoutePage.start);
            }
        ),
        ListTile(
          // Route to FeedBack
            leading: Icon(
              Icons.feedback_outlined,
              size: 40,
            ),
            title: Text(
                style: Theme.of(context).textTheme.titleMedium,
                '피드백'
            ),
            onTap: () {
              // 피드백으로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(context, RoutePage.start);
            }
        ),
        ListTile(
          // Route to Help
            leading: Icon(
              Icons.help,
              size: 40,
            ),
            title: Text(
                style: Theme.of(context).textTheme.titleMedium,
                '도움말'
            ),
            onTap: () {
              // 도움말로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(context, RoutePage.start);
            }
        ),
      ],  // Children End
    );  // ListView for Drawer
  }
}