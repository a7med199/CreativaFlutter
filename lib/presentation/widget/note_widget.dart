import 'package:flutter/material.dart';
import '../../core/colors_manager.dart';
import '../../data/note_model.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget({super.key, required this.data});
  NoteModel data;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 80,
          decoration: BoxDecoration(
            color: ColorsManagers.lightPurple,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),

                Text(
                  data.headLine,
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      data.description,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${data.createdAt.hour}:${data.createdAt.minute}${data.createdAt.hour >= 12? " Pm":" Am"}",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                if (data.mediaUrl != "")
                  Image.network(data.mediaUrl!)
              ],
            ),
          ),
        ),


      ],
    );
  }
}