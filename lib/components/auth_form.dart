import 'dart:io';

import 'package:chat_app/components/user_image_picker.dart';
import 'package:chat_app/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(50),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              SizedBox(height: 10.0),
              if (_formData.isSignup)
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(7.0),
                  child: TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(72, 90, 136, 1),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(244, 245, 247, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(72, 90, 136, 1), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(244, 245, 247, 1), width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.trim().length < 5) {
                        return 'Nome deve ter no mínimo 5 caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(72, 90, 136, 1),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(244, 245, 247, 1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(72, 90, 136, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(244, 245, 247, 1), width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  validator: (_email) {
                    final email = _email ?? '';
                    if (!email.contains('@')) {
                      return 'E-mail informado não é válido.';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(72, 90, 136, 1),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(244, 245, 247, 1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(72, 90, 136, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(244, 245, 247, 1), width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.length < 6) {
                      return 'Senha deve ter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 7, right: 7, top: 5),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    fixedSize: Size(MediaQuery.of(context).size.width, 0),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
