import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer_widget.dart';
import '../main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainAppContext>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    IconButton( // 뒤로 가기 버튼
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),),
                    Text(
                        '로그인',
                        style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),  // 뒤로 가기 버튼 컨테이너
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 50),
                child: Text(
                    '아이디',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),  // 아이디 레이블
              SizedBox(height: 2),
              Container(
                width: 300,
                height: 70,
                child: TextField(
                  expands: true,  // 텍스트 필드 크기 조정
                  minLines: null,
                  maxLines: null,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    hintText: '아이디를 입력하세요',
                    focusedBorder: OutlineInputBorder(  // 포커싱 됐을 때 스타일
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                    ),
                  ),
                ),
              ),  // 아이디 입력 컨테이너
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  '비밀번호',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),  // 비밀번호 레이블
              SizedBox(height: 2),
              Container(
                width: 300,
                height: 70,
                child: TextField(
                  expands: true,  // 텍스트 필드 크기 조정
                  minLines: null,
                  maxLines: null,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    focusedBorder: OutlineInputBorder(  // 포커싱 됐을 때 스타일
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                    ),
                  ),
                ),
              ),  // 비밀번호 입력 컨테이너
              SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Checkbox(
                        value: true,
                        onChanged: (value) {
                          // 체크 여부 따라 로직
                          // value가 nullable인 이유 찾기
                          // if (value) {
                          //   //
                          // }
                        },
                    ),
                    SizedBox(width: 1),
                    Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      '자동 로그인'
                    ),
                  ],
                ),
              ),  // 자동 로그인 컨테이너 영역
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                  ),
                  onPressed: () {
                  // 유효성 검사

                  // Json Parsing

                  // Park Aoun is Skin Head!
                  },
                  child: Text(
                    style: Theme.of(context).textTheme.labelLarge,
                    '로그인',
                  ),
                )
              ),  // 로그인 버튼 컨테이너
              // SizedBox(
              //   width: 350,
              //     height: 50,
              //     child: Divider(
              //       thickness: 2,
              //       color: Colors.black,
              //     ),
              // ),
              // SizedBox(height: 20),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Expanded(
              //       child: Divider(
              //         color: Colors.black,
              //         thickness: 2,
              //         endIndent: 8,
              //       ),
              //     ), // Left Divider
              //     Text(
              //       // font size 조정 필요
              //       style: Theme.of(context).textTheme.labelSmall,
              //       '또는',
              //     ),
              //     Expanded(
              //       child: Divider(
              //         color: Colors.black,
              //         thickness: 2,
              //         indent: 8,
              //       ),
              //     ),  // Right Divider
              //   ],
              // ),  // 일반 로그인 <=> SNS 연동 로그인 경계선
              // SizedBox(height: 15),
              // SNS 연동 로그인 버튼 위젯 추후 추가(기능 개발 미정)
            ],
          ),
        )
      )
    );
  }
}