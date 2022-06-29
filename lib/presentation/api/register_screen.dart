import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/domain/entities/user_data.dart';
import 'package:twitter_api/presentation/api/feed_screen.dart';
import 'package:twitter_api/presentation/api/login_screen.dart';
import 'package:twitter_api/services/flutter_fire_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  final _nameController = TextEditingController();
  final _arrobaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _arrobaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _navigateToRestricted(currentUser) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FeedPage(
            user: currentUser,
          ),
        ),
      );
    }

    void _submit() async {
      final name = _nameController.text;
      final arroba = _arrobaController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      setState(() => _isLoading = true);

      final user = await FlutterFireAuth(context)
          .createUserWithEmailAndPassword(name, arroba, email, password);
      setState(() => _isLoading = false);

      if (user != null) {
        _navigateToRestricted(user);
      }

      // var currentUser = FirebaseAuth.instance.currentUser;
      // if (currentUser != null) {
      //   _navigateToRestricted(currentUser);
      // }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cadastrar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome não pode ser vazio';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _arrobaController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Arroba não pode ser vazio';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Arroba',
                            prefixIcon: const Icon(Icons.alternate_email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Insira um e-mail valido",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Insira um e-mail',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira uma senha';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Insira uma senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Já possui uma conta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Entrar'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
