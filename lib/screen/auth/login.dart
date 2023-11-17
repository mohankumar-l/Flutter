import 'package:flash/navigation/bottom_tab_navigation.dart';
import 'package:flash/screen/gallery.dart';
import 'package:flash/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  navigationHandler(data) {
    if (kDebugMode) {
      print(data.user?.displayName.toString());
    }
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const BottomTabNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          'assets/images/background.jpg',
                          height: 240,
                          width: double.infinity,
                          repeat: ImageRepeat.repeat,
                        ),
                        Container(
                          margin: const EdgeInsets.all(30),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign in to your\nAccount',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                'Sign in to your Account',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Enter your email',
                              ),
                              controller: emailController,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: TextField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter your Password',
                              ),
                              controller: passwordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.fromLTRB(0, 15, 30, 15),
                      child: GestureDetector(
                        child: const Text(
                          "Forget password?",
                        ),
                        onTap: () {},
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromWidth(330),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Gallery()),
                          );
                        } else if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Please enter the valid Email and Password"),
                          ));
                        } else if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please enter the valid Email"),
                          ));
                        } else if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please enter the valid Password"),
                          ));
                        }
                      },
                      child: const Text('Login'),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 20,
                            indent: 30,
                          )),
                          Text("Or login with"),
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 30,
                            indent: 20,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final user = await signInWithGoogle();
                              navigationHandler(user);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                const Text("Google")
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final user = await signInWithFacebook();
                              navigationHandler(user);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/facebook.png',
                                  height: 20,
                                  width: 20,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(width: 10),
                                const Text("Facebook")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: GestureDetector(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              SizedBox(width: 8),
                              Text("Register")
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
