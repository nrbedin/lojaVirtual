import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/signup_screen.dart';

import '../helpers/snack_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          backgroundColor: (Theme.of(context).primaryColor),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                "CRIAR CONTA",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: (Theme.of(context).primaryColor),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.isEmpty || !text.contains("@"))
                          return "E-mail inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                        hintText: "Senha",
                      ),
                      obscureText: true,
                      validator: (text) {
                        if (text!.isEmpty || text.length < 6)
                          return "Senha inválida!";
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty)
                            SnackHelper.showSnack(
                                context: context,
                                text: "Insira seu e-mail para recuperação",
                                color: Colors.yellow);
                          else {
                            model.recoverPass(_emailController.text);
                            SnackHelper.showSnack(
                                context: context,
                                text: "Confira seu e-mail!",
                                color: Colors.green);
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      child: Text("Entrar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (Theme.of(context).primaryColor),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}

                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      },
                    ),
                  ],
                ));
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    SnackHelper.showSnack(
        context: context, text: "Falha ao entrar.", color: Colors.red);
  }
}
