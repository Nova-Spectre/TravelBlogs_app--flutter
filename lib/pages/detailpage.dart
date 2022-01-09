import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String imagel;
  final String discription;
  final String authorname;
  // ignore: non_constant_identifier_names
  final String Title;
  const DetailPage(
      {Key? key,
      required this.imagel,
      required this.discription,
      required this.authorname,
      // ignore: non_constant_identifier_names
      required this.Title})
      : super(key: key);

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50), topRight: Radius.zero),
                  child: CachedNetworkImage(
                    imageUrl: imagel,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                Title,
                style: const TextStyle(
                   
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
              ),
              const Divider(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person_outlined,
                      color: Colors.black45,
                      size: 15,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      authorname,
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                discription,
                  style: const TextStyle( fontSize: 20),
                  maxLines: 500,
                  softWrap: true,
      
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
