import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Gebruikersnaam'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Wachtwoord'),
                  ),
                  const Padding(padding: EdgeInsets.all(25)),
                  CustomButton(
                      key: const Key('login_button'),
                      onPressed: () => {
                        
                      },
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
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
