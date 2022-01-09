import 'dart:ui';

import 'package:blogapp/pages/create_blog.dart';
import 'package:blogapp/pages/detailpage.dart';
import 'package:blogapp/services/crud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  Stream? blogsStream;
  

  // ignore: non_constant_identifier_names
  Widget BlogsList() {
    return Container(
      child: blogsStream != null
          ? Expanded(
            child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: blogsStream,
                    builder: (context, snapshot) {
                      if(snapshot.data == null) return const CircularProgressIndicator();
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(
                                  imagel:  (snapshot.data! as QuerySnapshot).docs[index]['imgUrl'],
                                   discription: (snapshot.data! as QuerySnapshot).docs[index]['description'],
                                    authorname: (snapshot.data! as QuerySnapshot).docs[index]['authorName'],
                                    Title:(snapshot.data! as QuerySnapshot).docs[index]["title"] )));
                              },
                              child: BlogsTile(
                                authorName: (snapshot.data! as QuerySnapshot).docs[index]['authorName'],
                                title: (snapshot.data! as QuerySnapshot).docs[index]["title"],
                                description:
                                    (snapshot.data! as QuerySnapshot).docs[index]['description'],
                                imgUrl:
                                    (snapshot.data! as QuerySnapshot).docs[index]['imgUrl'],
                              ),
                            );
                          });
                    },
                  )
                ],
              ),
          )
          : Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                
              ),
            ),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: BlogsList()),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          
      
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateBlog()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile(
      {Key? key, required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,
                  color: Colors.white,
                  shadows: [
                     Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(15, 15),
                blurRadius: 15),
          
                  ]
                  
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                
                const SizedBox(
                  height: 4,
                ),
                Text(authorName,style: const TextStyle(color: Colors.white,
                ),)
              ],
            ),
          ),
          const Divider(color: Colors.grey)
        ],
      ),
    
    );
  }
}