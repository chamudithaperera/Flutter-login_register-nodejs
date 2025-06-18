import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../config.dart';
import '../models/login_request_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool hidePassword = true;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3ED),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242424),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Email Field
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? "Email can't be empty."
                              : null,
                  onSaved: (val) => userName = val,
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: hidePassword,
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? "Password can't be empty."
                              : null,
                  onSaved: (val) => password = val,
                ),
                const SizedBox(height: 32),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5C00),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isApiCallProcess ? null : _submit,
                  child:
                      isApiCallProcess
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
                const SizedBox(height: 16),

                // Register Link
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Create new account',
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isApiCallProcess = true);
      final model = LoginRequestModel(username: userName, password: password);
      APIService.login(model).then((response) {
        setState(() => isApiCallProcess = false);
        if (response) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text(Config.appName),
                  content: const Text("Invalid Username/Password !!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }
      });
    }
  }
}
