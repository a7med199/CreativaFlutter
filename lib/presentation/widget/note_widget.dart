
import 'package:flutter/material.dart';

import '../../data/note_model.dart';

class NoteWidget extends StatelessWidget {
  NoteModel noteModel;
  NoteWidget({super.key,required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 80,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 214, 241, 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(noteModel.headline,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 3,
              ),
              Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        noteModel.description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    Text("${noteModel.createdAt.hour}:${noteModel.createdAt.minute}${noteModel.createdAt.hour>12 ? "PM" : "AM" }",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
