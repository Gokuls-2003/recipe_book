// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pratice_project/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _LoginFormkey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
        ),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _LoginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Recip Book',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _LoginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
          key: _LoginFormkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: 'kminchelle',
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a User Name';
                  }
                },
                decoration: const InputDecoration(hintText: 'user name'),
              ),
              TextFormField(
                initialValue: '0lelplR',
                obscureText: true,
                onSaved: (Value) {
                  setState(() {
                    password = Value;
                  });
                },
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Enter a Valid password';
                  }
                },
                decoration: const InputDecoration(hintText: 'password'),
              ),
              _LoginButton()
            ],
          )),
    );
  }

  Widget _LoginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
          onPressed: () async {
            if (_LoginFormkey.currentState?.validate() ?? false) {
              _LoginFormkey.currentState?.save();
              bool result = await AuthService().login(username!, password!);
              if (result) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                StatusAlert.show(context,
                    duration: const Duration(seconds: 2),
                    title: 'Login Failed',
                    subtitle: 'Please try again',
                    configuration: const IconConfiguration(
                      icon: Icons.error,
                    ),
                    maxWidth: 260);
              }
            }
          },
          child: const Text('Login')),
    );
  }
}
