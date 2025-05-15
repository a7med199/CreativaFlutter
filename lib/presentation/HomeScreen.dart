import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/logic/get_notes/cubil.dart';
import 'package:untitled1/logic/get_notes/state.dart';
import 'package:untitled1/presentation/create_note_screen.dart';
import 'package:untitled1/presentation/widget/note_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 3, 17, 1),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c){return CreateNoteScreen();}));
                      },
                      canRequestFocus: false,
                      enableFeedback: false,
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        child: const Text("Add Note",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 19, 19, 19),
                            )),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      canRequestFocus: false,
                      enableFeedback: false,
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        child: const Text("Log out",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 19, 19, 19),
                            )),
                      )),
                ],
              ),
              const SizedBox(height: 22),

              BlocBuilder<GetNoteCubit, GetNoteStates>(
                builder: (context, state) {
                  if (state is GetNoteLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }else if (state is GetNoteSuccessState){
                    final x = state.notesData;
                    return SizedBox(
                      height: 700,
                      child: ListView.builder(
                        itemCount: x.length,
                        itemBuilder: (context, index) {
                          final y = x[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: NoteWidget(
                              noteModel: y,
                            ),
                          );
                        },
                      ),
                    );
                  }else if (state is GetNoteErrorState){
                    return Center(child: Text(state.message));
                  }else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}