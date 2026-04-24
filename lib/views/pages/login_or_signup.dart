import "package:adventure_log/data/user_queries.dart";
import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "../../controllers/utils/validators.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isSignedIn = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 50,
            children: [
              headerText("You must sign in to access this app", context),
              Container(
                width: responsiveWidth(context, 800),
                padding: const EdgeInsets.all(20),
                color: mint,
                child: Column(
                  spacing: 20,
                  children: [
                    const SizedBox(height: 20),
                    if (!_isSignedIn)
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Display name",
                        ),
                        validator: requireNonEmptyString,
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: requireNonEmptyString,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),
                    if (_error != null)
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    appThemedButton(
                      context,
                      _submit,
                      _isSignedIn ? "Sign In" : "Sign Up",
                    ),
                    TextButton(
                      onPressed: _toggleMode,
                      child: Text(
                        _isSignedIn
                            ? "No account? Sign up"
                            : "Already have an account? Sign in",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _error = null;
    });

    try {
      if (_isSignedIn) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        final user = credential.user;
        if (user != null) {
          addUserToFirestore(_nameController.text.trim());
        }
      }
    } catch (_) {
      setState(() {
        _error = "Something went wrong, probably incorrect password/email";
      });
    }
  }

  void _toggleMode() {
    setState(() {
      _isSignedIn = !_isSignedIn;
      _error = null;
    });
  }
}
