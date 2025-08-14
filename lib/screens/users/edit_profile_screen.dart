import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_provider.dart';
import '../../services/user_provider.dart';
import '../../config/appTheme.dart';
import '../../api/user/edit_account_api.dart';
import '../../widgets/common_widget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    final userManager = context.read<UserProvider>();
    _username = userManager.username ?? "";
    _email = userManager.email ?? "";
  }

  @override
  Widget build(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;
    final theme = AppTheme.lightTheme;

    return Scaffold(
      appBar: AppBar(title: Text('내 정보 수정')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 프로필 이미지
              GestureDetector(
                onTap: () {
                  // 이미지 변경 기능 (선택적)
                },
                child: CircleAvatar(
                  radius: w * 0.2,
                  child: Icon(Icons.account_circle, size: w * 0.4),
                ),
              ),
              SizedBox(height: 24),

              // 닉네임
              TextFormField(
                initialValue: _username,
                decoration: InputDecoration(
                  labelText: '닉네임',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => _username = val,
                validator: (val) {
                  if (val == null || val.isEmpty) return '닉네임을 입력하세요';
                  return null;
                },
              ),
              SizedBox(height: 16),

              // 이메일
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => _email = val,
                validator: (val) {
                  if (val == null || val.isEmpty) return '이메일을 입력하세요';
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                    return '유효한 이메일을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),

              // 저장 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EditAccountApi accountEditor = EditAccountApi();
                      CommonWidget widgetMaker = CommonWidget();
                      if (!await accountEditor.editAccount(_email, _username)) {
                        widgetMaker.buildSnackBar(ctx, '회원 정보 수정에 실패했습니다', theme);
                        return;
                      }
                      final userManager = ctx.read<UserProvider>();
                      userManager.updateUserData(_username, _email);
                      widgetMaker.buildSnackBar(ctx, '회원 정보 수정에 성공했습니다', theme);
                      Navigator.pop(ctx);
                    }
                  },
                  child: Text('저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}