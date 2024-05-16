import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text('Login', style: TextStyle(fontSize: 50))),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Gebruikersnaam'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Wachtwoord'),
              ),
              Padding(padding: const EdgeInsets.all(25)),
              CustomButton(
                  key: const Key('login_button'),
                  onPressed: () => {},
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ],
    ));
  }
}
