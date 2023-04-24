import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/snack_helper.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          backgroundColor: (Theme.of(context).primaryColor),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Nome Completo",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Nome inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
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
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: "Endereço",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Endereço inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      child: Text("Criar conta"),
                      style: ElevatedButton.styleFrom(
                        primary: (Theme.of(context).primaryColor),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                          };
                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                    ),
                  ],
                ));
          },
        ));
  }

  void _onSuccess() {
    SnackHelper.showSnack(
        context: context,
        text: "Usuário criado com sucesso!",
        color: Colors.green);

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    SnackHelper.showSnack(
        context: context, text: "Falha ao criar usuário!", color: Colors.red);
  }
}
