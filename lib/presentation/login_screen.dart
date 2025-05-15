import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/logic/login/cubil.dart';
import 'package:untitled1/logic/login/state.dart';
import 'package:untitled1/presentation/signup_screen.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController  = TextEditingController();

  TextEditingController passController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(

        listener: (context, state) {

      if (state is LoginSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Your Account Was Created Successfully")));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        },));

      }else if (state is LoginErrorState){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.em)));
      }
    },
          // TODO: implement listener

        builder: (context, state) {
          return Scaffold(
              backgroundColor: Color.fromRGBO(18, 3, 17, 1),
              body: Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 80, right: 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Text(
                            "HI, Welcome back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold

                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold

                          )
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
                            border: InputBorder.none
                        ),
                      ),

                      SizedBox(
                        height: 14,
                      ),

                      Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold

                          )
                      ),

                      SizedBox(
                        height: 14,
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
                            border: InputBorder.none
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<LoginCubit>().Login(emailController.text, passController.text);
                        },
                        child: Center(
                            child: Container(
                              width: 312,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Center(child: Text("Login",
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
                      SizedBox(
                        height: 20,
                      ),

                      InkWell(
                        onTap: () {

                        },

                        child: Center(
                            child: Container(

                              width: 312,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),

                              child: Center(child: Text("Continue With Gmail",
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
                      SizedBox(
                        height: 240,
                      ),


                      Center(
                        child: TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        }, child: Text("Do not have an account? SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),),
                      )
                    ]
                ),
              )
          );
        },
      ),
    );
  }
}
