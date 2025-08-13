import 'package:flutter/material.dart';

class WidgetConfig {
  static const inputSettings = {
    '이메일': {
      'hint': '이메일을 입력하세요',
      'keyboard': TextInputType.emailAddress,
      'obscure': false,
    },
    '비밀번호': {
      'hint': '비밀번호를 입력하세요',
      'keyboard': TextInputType.text,
      'obscure': true,
    },
    '비밀번호 확인': {
      'hint': '비밀번호를 다시 한번 입력하세요',
      'keyboard': TextInputType.text,
      'obscure': true,
    },
    '닉네임': {
      'hint': '닉네임을 입력하세요',
      'keyboard': TextInputType.text,
      'obscure': false,
    },
  };
}