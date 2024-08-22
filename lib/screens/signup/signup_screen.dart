import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login/login_screen.dart';
import 'package:flutter_task/widgets/appbar_widget.dart';
import 'package:flutter_task/widgets/material_button.dart';
import 'package:flutter_task/widgets/textformfields.dart';

import '../authentication/auth_service.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var password = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  bool pwdVisible = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Singup Successfully. Please Login..",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Enter Correct EMail and Password");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Enter Correct EMail and Password",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        text: "User SignUp",
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
                  child: Image.asset('assets/signup.jpeg'),
                ),
                TextFormFields(
                  controller: nameController,
                  hintText: 'Enter your name',
                  keyboardType: TextInputType.text,
                  prefixIconData: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter name';
                    }
                    return null;
                  },
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
                isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0XFFB81736),
                  ),
                )
                    : MaterialButtonDesign(
                  height: 40,
                  width: 200,
                  text: 'Sign Up',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        name=nameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      signupUser();
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account? ",
                      style: TextStyle(fontSize: 17, color: Colors.pink),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const Login(),
                            transitionDuration:
                            const Duration(seconds: 0),
                          ),
                        )
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17, color: Colors.pink),
                      ),
                    )
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


