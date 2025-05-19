import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../data/note_model.dart';
import '../logic/create_note/cubit.dart';
import '../logic/create_note/state.dart';
import 'home_screen.dart';

import '../core/colors_manager.dart';


class CreateNoteScreen extends StatefulWidget {
  CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController headLineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  XFile? selectedMedia;

  Future selectMedia() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      choseMediaGallery();
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
                          "Gallery".tr(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorsManagers.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: InkWell(
                    onTap: () {
                      choseMediaCamera();
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
                          "Camera".trim(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorsManagers.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future choseMediaGallery() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedMedia = image;
      });
    }
  }

  Future choseMediaCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedMedia = image;
      });
    }
  }

  Future<String?> uploadMedia() async {
    final location = FirebaseStorage.instance.ref().child("noteImage/");
    await location.putFile(File(selectedMedia!.path));
    return location.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNoteCubit(),
      child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
        listener: (context, state) {
          if (state is CreateNoteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note was created Successfully".tr())),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (state is CreateNoteErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.em)));
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
                  SizedBox(height: 40),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
                  Center(
                    child: Text(
                      "Create New Note ".tr(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "headline ".tr(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: headLineController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: ColorsManagers.lightPurple,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Description ".tr(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: ColorsManagers.lightPurple,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 12),
                  if (selectedMedia != null)
                    Center(
                        child: Image.file(File(selectedMedia!.path),
                            height: 300)),
                  Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () {
                        selectMedia();
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
                            "Select Media".tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorsManagers.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (selectedMedia != null) {
                          final mediaLink = await uploadMedia();
                          context.read<CreateNoteCubit>().createNoteData(
                              NoteModel(
                                headLine: headLineController.text,
                                description: descriptionController.text,
                                createdAt: DateTime.now(),
                                mediaUrl: mediaLink,
                              ));
                        } else {
                          context.read<CreateNoteCubit>().createNoteData(
                              NoteModel(
                                  headLine: headLineController.text,
                                  description: descriptionController.text,
                                  createdAt: DateTime.now()));
                        }
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
                            "Create".tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorsManagers.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}