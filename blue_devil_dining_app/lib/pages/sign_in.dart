import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:blue_devil_dining_app/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase(pocketbaseUrl);

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  onSignInButtonPressed() async {
    setState(() => isLoading = true);
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final authData =
          await pb.collection("users").authWithPassword(email, password);
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageNames.HOME_PAGE.name,
        (route) => false,
        arguments: authData.record,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      alertUser(e.toString(), context);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: standardPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: standardSeparation * 4),
              Text(
                "Sign In",
                style: GoogleFonts.playfairDisplay().copyWith(
                  fontSize: standardSeparation * 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Join the community!",
                style: TextStyle(fontSize: standardSeparation * 1.5),
              ),
              const SizedBox(height: standardSeparation * 6),
              TextField(
                decoration: const InputDecoration(
                  hintText: "john.doe@duke.edu",
                  label: Text("email"),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: standardSeparation * 2),
              TextField(
                decoration: const InputDecoration(
                  hintText: "MySecurePassword",
                  label: Text("password"),
                ),
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: standardSeparation / 2),
              const Text(
                "Forgot password?",
                style: TextStyle(color: primaryColor),
              ),
              const SizedBox(height: standardSeparation * 3),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : onSignInButtonPressed,
                  icon: isLoading
                      ? Container(
                          margin: const EdgeInsets.all(standardSeparation / 2),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "sign in",
                          style: TextStyle(fontSize: standardSeparation * 1.2),
                        ),
                  label: isLoading
                      ? const Text("")
                      : const Icon(Icons.arrow_forward),
                ),
              ),
              const SizedBox(height: standardSeparation * 8),
              Center(
                child: Image.asset(
                  "assets/images/duke_logo.png",
                  height: standardSeparation * 10,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
