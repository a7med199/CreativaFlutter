import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/colors_manager.dart';
import '../logic/signup/cubit.dart';
import '../logic/signup/state.dart';
import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if(state is SignUpSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          }

        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManagers.primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Text(
                      "Create New Account ".trim(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Email ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: "example@gmail.com".trim(),
                        fillColor: ColorsManagers.lightPurple,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "password ".trim(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter Your password".trim(),
                        fillColor: ColorsManagers.lightPurple,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () {
                        context.read<SignUpCubit>().signUp(emailController.text, passController.text);
                      },
                      child: Container(
                        width: 312,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up".trim(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorsManagers.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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