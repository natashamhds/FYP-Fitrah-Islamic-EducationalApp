import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/ForgotPassword/forgot_password_page.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Register/register_page.dart';
import 'package:fitrah/widgets/my_button.dart';
import 'package:fitrah/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  // text editing controllers - to keep track of what's inside when user types
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signIn() async {
    // display loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(color: darkBlue));
      },
    );

    // try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // display success message to the user and head to the main page
      successLogin();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      // wrong e-Mail
      if (e.code == 'user-not-found') {
        // display error to the user
        wrongEmailMessage();
      }
      // wrong password
      else if (e.code == 'wrong-password') {
        // display error to the user
        wrongPasswordMessage();
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
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
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Assamualaikum!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    fontFamily: 'circe'),
              ).animate().fade(duration: 1300.ms).slide(),

              const SizedBox(height: 10),

              const Text(
                "Selamat Kembali, kami merindui kamu!",
                style: TextStyle(fontSize: 20, fontFamily: 'circe'),
              ),

              const SizedBox(height: 10),

              // e-Mail textfield
              MyTextField(
                controller: emailController,
                labelText: "e-Mel",
                obscureText: false,
                icon: Icon(Icons.mail, color: darkBlue),
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                  controller: passwordController,
                  labelText: "Kata laluan",
                  obscureText: isObscure,
                  icon: Icon(Icons.lock, color: darkBlue),
                  icon1: IconButton(
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: darkBlue),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      })),

              const SizedBox(height: 10),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()))
                      },
                      child: const Text(
                        "Lupa kata laluan",
                        style: TextStyle(
                            fontFamily: 'circe', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                text: "LOG MASUK",
                onTap: signIn,
              ),

              const SizedBox(height: 25),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bukan ahli?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'circe')),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      )
                    },
                    child: Text(" Daftar Sekarang",
                            style: TextStyle(
                                color: purple,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'circe'))
                        .animate()
                        .shake(duration: 900.ms),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void wrongEmailMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Tiada Akaun Ditemui",
        message: "Tiada akaun ditemui dengan e-Mel tersebut",
        color: Colors.red,
        contentType: ContentType.failure,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void wrongPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Kata laluan salah",
        message:
            "Cuba lagi atau klik Lupa Kata Laluan untuk menetapkannya semula",
        color: Colors.red,
        contentType: ContentType.failure,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void successLogin() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Log masuk berjaya",
        message: "Anda kini boleh menggunakan aplikasi",
        color: Colors.lightGreen,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
