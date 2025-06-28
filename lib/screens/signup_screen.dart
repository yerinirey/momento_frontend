import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onSignupPressed() {
    final id = _idController.text;
    final email = _emailController.text;
    final pw = _pwController.text;
    final confirm = _confirmController.text;
    // db에 id, email validation넘겨서 검증
    if (pw != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }
    // print('회원가입 시도: id=\$id, email=\$email');
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
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              // ID
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
              // 이메일
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: _buildBorder(Colors.grey),
                  enabledBorder: _buildBorder(Colors.grey),
                  focusedBorder: _buildBorder(Colors.blue),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // PW
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
              const SizedBox(height: 16),
              // PW 확인
              TextField(
                controller: _confirmController,
                decoration: InputDecoration(
                  labelText: 'PW 확인',
                  border: _buildBorder(Colors.grey),
                  enabledBorder: _buildBorder(Colors.grey),
                  focusedBorder: _buildBorder(Colors.blue),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // 회원가입
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _onSignupPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
