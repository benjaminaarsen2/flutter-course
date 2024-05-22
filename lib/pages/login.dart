import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/global_context.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/providers/secure_storage_provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login', style: TextStyle(fontSize: 50)),
            Container(
              padding: const EdgeInsets.all(20),
              child: LoginForm(),
            ),
          ],
        ),
        const Positioned(
          bottom: 20,
          child: Column(
            children: [
              Text('made by',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  )),
              SizedBox(
                  width: 100,
                  child:
                      Image(image: AssetImage('assets/images/b302-logo.png'))),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Gebruikersnaam'),
            validator: (value) =>
                value!.isEmpty ? 'Vul een gebruikersnaam in' : null,
            onChanged: (value) => email = value,
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Wachtwoord'),
            validator: (value) =>
                value!.isEmpty ? 'Vul een wachtwoord in' : null,
            onChanged: (value) => password = value,
          ),
          const Padding(padding: EdgeInsets.all(25)),
          CustomButton(
              key: const Key('login_button'),
              onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        login(email, password)
                            .then((accessToken) => {
                                  SecureStorage().write('jwt', accessToken),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Login successful'))),
                                })
                            .catchError((error) => {print(error)})
                      }
                  },
              child:
                  const Text('Login', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
