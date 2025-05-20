
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verstak/api_service.dart';
import 'package:verstak/main.dart';
import 'package:verstak/navigation_cubit.dart';
import 'package:verstak/pages/user/welcome_page.dart';
import 'package:verstak/product.dart';

import '../../widgets/custom_button.dart';
import '../home_page.dart';


class LoginPage extends StatefulWidget {
  final bool newUser;
  final ApiService apiService;
  final List<Product> products;

  const LoginPage({
    super.key,
    required this.newUser,
    required this.apiService,
    required this.products
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _supabase = Supabase.instance.client;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Пожалуйста, заполните все поля";
        _isLoading = false;
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _errorMessage = "Пожалуйста, введите корректный email";
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = "Не удалось войти. Проверьте email и пароль.";
            _isLoading = false;
          });
        }
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Err: ${e.toString()}";
        _isLoading = false;
      });
    }
  }


  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty) {
      setState(() {
        _errorMessage = "Пожалуйста, заполните все поля";
        _isLoading = false;
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _errorMessage = "Пожалуйста, введите корректный email";
        _isLoading = false;
      });
      return;
    }

    // Проверка совпадения паролей
    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Пароли не совпадают";
        _isLoading = false;
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _errorMessage = "Пароль должен содержать не менее 6 символов";
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': name,
        },
      );

      if (response.user != null) {

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Регистрация успешна!"),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = "Не удалось зарегистрироваться. Попробуйте еще раз.";
            _isLoading = false;
          });
        }
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Произошла ошибка: ${e.toString()}";
        _isLoading = false;
      });
    }
  }


  Widget passwordConfirm(double width, double height) {
    return Column(
      children: [
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 22.5),
          child: Row(
            children: [
              const Text(
                "Подтвердите пароль",
                style: TextStyle(
                    color: Color(0xFF636060),
                    fontSize: 20,
                    fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEDEDED)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userName(double width, double height) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 22.5),
          child: Row(
            children: [
              const Text(
                "Имя пользователя",
                style: TextStyle(
                    color: Color(0xFF636060),
                    fontSize: 20,
                    fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEDEDED)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187A3F),
      ),
      body: Column(
        children: [

          widget.newUser
              ? userName(screenWidth, screenHeight * 0.05)
              : SizedBox.shrink(),

          SizedBox(height: widget.newUser ? 5 : 20),
          Padding(
            padding: const EdgeInsets.only(left: 22.5),
            child: Row(
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      color: Color(0xFF636060),
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEDEDED)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 22.5),
            child: Row(
              children: [
                const Text(
                    "Пароль",
                  style: TextStyle(
                      color: Color(0xFF636060),
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEDEDED)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),


          widget.newUser
              ? passwordConfirm(screenWidth, screenHeight * 0.05)
              : SizedBox.shrink(),


          SizedBox(height: 15),
          CustomButton(
            padding: 0,
            onTap: () {
              widget.newUser ? _signUp() : _signIn();
            },
            splashColor: Colors.white.withValues(alpha: 0.1),
            highlightColor: Colors.white.withValues(alpha: 0.1),
            mainColor: Color(0xFF187A3F),
            extraShadow: false,
            width: screenWidth * 0.5,
            height: screenHeight * 0.04,
            text: widget.newUser ? "Регистрация" : "Войти",
            textColor: Colors.white,
            fontSize: 20,
            hasIcon: false,
          ),

        ],
      ),
    );
  }
}
