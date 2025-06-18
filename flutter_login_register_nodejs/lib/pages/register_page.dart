import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../config.dart';
import '../models/register_request_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String? userName;
  String? password;
  String? email;
  String? confirmPassword;

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
                  'Register',
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
                  onSaved: (val) => email = val,
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
                  onChanged: (val) => password = val,
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: hideConfirmPassword,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Confirm password can't be empty.";
                    }
                    if (val != password) {
                      return "Passwords don't match.";
                    }
                    return null;
                  },
                  onSaved: (val) => confirmPassword = val,
                ),
                const SizedBox(height: 32),

                // Register Button
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
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
                const SizedBox(height: 16),

                // Login Link
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Already have an account? Login',
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
      final model = RegisterRequestModel(
        username: userName,
        password: password,
        email: email,
      );
      APIService.register(model).then((response) {
        setState(() => isApiCallProcess = false);
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text(Config.appName),
                content: Text(response.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (response.data != null) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      });
    }
  }
}
