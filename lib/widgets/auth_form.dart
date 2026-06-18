import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.isLoading, required this.onSubmit});

  final bool isLoading;
  final void Function({
    required String email,
    required String password,
    required BuildContext context,
    required bool isLogin,
    String? username,
  })
  onSubmit;

  @override
  State<StatefulWidget> createState() {
    return _AuthFormState();
  }
}

class _AuthFormState extends State<AuthForm> {
  late final theme = Theme.of(context);
  var isPasswordVisible = false;
  var isLogin = true;

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;

  void _saveForm() {
    FocusScope.of(context).unfocus();

    var isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();

      widget.onSubmit(
        email: email!.trim(),
        password: password!.trim(),
        isLogin: isLogin,
        context: context,
        username: username?.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).viewInsets.bottom;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          children: [
            Image.asset('assets/images/app_logo.jpeg', height: 100,),
            const SizedBox(height: 40,),
            Card(
            margin: const .symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: .fromLTRB(40, 40,40, paddingBottom + 80),
                child: Column(
                  mainAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                      keyboardType: .emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        label: Text('Email'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 5 ||
                            !value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value,
                    ),
                    const SizedBox(height: 5),
                    if (!isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        keyboardType: .text,
                        style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          label: Text('Username'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 4) {
                            return 'Invalid username';
                          }
                          return null;
                        },
                        onSaved: (value) => username = value,
                      ),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: const ValueKey('password'),
                      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                      keyboardType: .visiblePassword,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          }),
                          icon: isPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length <= 6) {
                          return 'Password must be at least 7 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) => password = value,
                    ),

                    const SizedBox(height: 20),
                    //buttons
                    if(widget.isLoading)
                      const CircularProgressIndicator()
                    else
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Text(isLogin ? 'Login' : 'Signup'),
                    ),
                    TextButton(
                      onPressed: () => setState(() {
                        isLogin = !isLogin;
                      }),
                      child: Text(
                        isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )],
        ),
      ),
    );
  }
}
