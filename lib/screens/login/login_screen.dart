import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/forgotpassword/forgot_password.dart';
import 'package:flutter_task/screens/signup/signup_screen.dart';
import 'package:flutter_task/widgets/appbar_widget.dart';
import 'package:flutter_task/widgets/material_button.dart';
import 'package:flutter_task/widgets/textformfields.dart';
import '../home_screen/ui/user_main.dart';
import '../authentication/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool pwdVisible = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserMain(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Email and password is wrong",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        text: "User Login",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: height / 2.7,
                  child: Image.asset('assets/login.jpg'),
                ),
                TextFormFields(
                  controller: emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.text,
                  prefixIconData: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                TextFormFields(
                  obscureText: !pwdVisible,
                  controller: passwordController,
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  prefixIconData: Icons.password,
                  suffixIconData: IconButton(
                    icon: Icon(
                      pwdVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0XFFB81736),
                    ),
                    onPressed: () => setState(
                          () => pwdVisible = !pwdVisible,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        )
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0XFFB81736),
                        ),
                      )
                    : MaterialButtonDesign(
                        height: 40,
                        width: 200,
                        text: 'Login',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            loginUser();
                          }
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an Account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.pink),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => const Signup(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.pink),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () => {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         PageRouteBuilder(
                    //           pageBuilder: (context, a, b) => UserMain(),
                    //           transitionDuration: const Duration(seconds: 0),
                    //         ),
                    //         (route) => false)
                    //   },
                    //   child: const Text('Dashboard'),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
