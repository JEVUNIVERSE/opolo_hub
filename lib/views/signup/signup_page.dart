import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';

class SignnUpPage extends StatefulWidget {
  const SignnUpPage({super.key});

  @override
  State<SignnUpPage> createState() => _SignnUpPageState();
}

class _SignnUpPageState extends State<SignnUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final fAuth = FirebaseAuth.instance;

  bool loading = false;

  createAccount() async {
    setState(() {
      loading = true;
    });
    await fAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginUpPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.pink,
                  enabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide())),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide())),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              height: 50,
              minWidth: 200,
              onPressed: () {
                createAccount();
              },
              color: Colors.black,
              child: Text("Sign up", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 24,
            ),
            loading
                ? Container(
                    height: 100, width: 100, child: CircularProgressIndicator())
                : const SizedBox.shrink(),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginUpPage()),
                  );
                },
                child: const SizedBox(
                    height: 100, width: 200, child: Text("Sign In")))
          ],
        ),
      ),
    );
  }
}
