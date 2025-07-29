import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
              child: Row(
                children: [
                  IconButton( // 뒤로 가기 버튼
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),),
                  Text(
                      '회원 가입',
                      style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            )
        )
    );
  }
}