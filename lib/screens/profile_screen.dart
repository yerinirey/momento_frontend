import 'package:flutter/material.dart';
import 'package:momento/screens/signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final id = _idController.text;
    final pw = _pwController.text;
    //
    print('Login 시도\t$id, $pw');
  }

  void _onKakaoLogin() {
    //
    print('Kakao 로그인');
  }

  void _onSignUp() {
    // 회원가입 화면 이동
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    // input textfield 포커스 시 경계색깔 통일용
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
                border: _buildBorder(Colors.grey),
                enabledBorder: _buildBorder(Colors.grey),
                focusedBorder: _buildBorder(Colors.blue),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pwController,
              decoration: InputDecoration(
                labelText: 'PW',
                border: _buildBorder(Colors.grey),
                enabledBorder: _buildBorder(Colors.grey),
                focusedBorder: _buildBorder(Colors.blue),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white, // 텍스트 흰색
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onKakaoLogin,
                icon: Image.network(
                  'https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png',
                  width: 28,
                  height: 28,
                ),
                label: const Text(
                  '카카오 로그인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEE100), // 카카오 옐로우
                  minimumSize: const Size.fromHeight(48), // 높이 48
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 모서리 둥글게
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _onSignUp,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white, // 배경 흰색
                  minimumSize: const Size.fromHeight(48), // 높이 48
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 모서리 둥글게
                  ),
                  side: const BorderSide(color: Colors.black45), // 검정 경계선
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.black, // 텍스트 검정
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
