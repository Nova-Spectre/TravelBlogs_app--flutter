import 'dart:io';
import 'package:blogapp/services/crud.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, description;
  File? selectedImage;
  bool _isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = File(await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((value) => value!.path));
    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      
      //upload image to firebase
      firebase_storage.Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("BlogImage")
          .child("${randomAlphaNumeric(9)}.jpg");
      final firebase_storage.UploadTask task =
          firebaseStorageRef.putFile(selectedImage!);

      var downldUrl = await (await task).ref.getDownloadURL();
     

      Map<String,String> blogmap ={
        "imgUrl":downldUrl,
        "authorName": authorName,
        "title":title,
        "description":description,
      };
      crudMethods.addData(blogmap).then((results) {

      Navigator.pop(context);
      });

    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFE6E6E6),
      appBar: AppBar(
        iconTheme: const IconThemeData(
    color: Color(0xFF14279B), //change your color here
  ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Travel",
              style: TextStyle(fontSize: 22,color: Color(0xFF14279B),fontFamily: 'PermanentMarker'),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Color(0xFF5C7AEA),fontFamily: 'Abeeze'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: selectedImage != null
                      ? Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(hintText: "Title Name"),
                        onChanged: (value) => title = value,
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: "Author Name"),
                        onChanged: (value) => authorName = value,
                      ),
                      SingleChildScrollView(
                        child: TextField(
                          decoration: const InputDecoration(hintText: "Description "),
                          maxLines: 500,
                          minLines: 10,
                          keyboardType: TextInputType.multiline,
                          
                          onChanged: (value) => description = value,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
    );
  }
}
