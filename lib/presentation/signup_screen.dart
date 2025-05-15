import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/signup/cubil.dart';
import '../logic/signup/state.dart';
import 'HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
 const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController  = TextEditingController();

  TextEditingController passController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Your Account Was Created Successfully")));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
            },));

          }else if (state is SignUpErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.em)));
          }
        },
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Color.fromRGBO(18, 3, 17, 1),
            body: Padding(
              padding: const EdgeInsets.only(left: 32, top: 80, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        filled: true,
                        fillColor: Color.fromRGBO(242, 214, 241, 0.08),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: passController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        filled: true,
                        fillColor: Color.fromRGBO(242, 214, 241, 0.08),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<SignUpCubit>().signUp(emailController.text, passController.text);
                    },
                    child: Center(
                      child: Container(
                          width: 312,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Center(child: Text("SignUp",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}