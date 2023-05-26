import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Login/login_page.dart';
import 'package:fitrah/widgets/my_button.dart';
import 'package:fitrah/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //text controller
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      // display success message to the user
    } on FirebaseAuthException catch (e) {
      // invalid e-Mail
      if (e.code == 'invalid-email') {
        // displaye error to the user
        invalidEmail();
      } else if (e.code == 'user-not-found') {
        // display error to the user
        wrongEmailMessage();
      }
      // pop the loading circle
      Navigator.pop(context);
      // stay at the forgot password page if failure
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
    }
    // pop the loading circle
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // display success message to the user
    successReset();
    // head to the login page after successful registration
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: size.width * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/padlock.png'),
                      fit: BoxFit.contain)),
            ),

            const SizedBox(height: 15),

            const Text(
              "Lupa Kata Laluan",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  fontFamily: 'circe'),
            ),

            const SizedBox(height: 10),

            const Text(
                "Sila masukkan e-mel anda. \nAnda akan menerima pautan untuk \nmembuat kata laluan baru melalui e-Mel.",
                style: TextStyle(fontSize: 20, fontFamily: 'circe'),
                textAlign: TextAlign.center),

            const SizedBox(height: 10),

            // e-mail textfield
            MyTextField(
                controller: emailController,
                labelText: "e-Mel",
                obscureText: false,
                icon: Icon(Icons.mail, color: darkBlue)),

            const SizedBox(height: 25),

            // submit buton
            MyButton(onTap: () => passwordReset(), text: "HANTAR")
          ],
        ),
      ),
    )));
  }

  void invalidEmail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "e-Mel tidak sah",
        message: "Sila isi e-Mel yang sah",
        color: Colors.yellow,
        contentType: ContentType.warning,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
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

  void successReset() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "e-Mel Dihantar",
        message: "e-Mel telah dihantar ke ${emailController.text.trim()}",
        color: Colors.lightGreen,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
