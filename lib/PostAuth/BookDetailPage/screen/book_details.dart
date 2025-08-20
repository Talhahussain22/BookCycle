import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/bloc/book_detials_bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/repository/chatrepo.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/screen/chatpage.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetails extends StatelessWidget {
  BookModel book;
  BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String imageurl = "${dotenv.get('imagefetchurl')}${book.imagepath}";

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      body: BlocListener<BookDetialsBloc,BookDetialsState>(
        listener: (context,state){
          if(state is BookDetailsLoadedState)
            {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(personimagepath: state.data?['imagepath'], personName: '${state.data?['first name']} ${state.data?['last name']}', bookimagepath: book.imagepath, booktitle: book.title, bookprice: book.price,chatdoc: state.chatdoc)));
            }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageurl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorWidget: (context, _, stacktrace) {
                      return Container(
                        color: Colors.purple.shade50,
                        height: 300,
                        width: double.infinity,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.back,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      book.price,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      book.title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.blue.shade700,
                          size: 13,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          book.location,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Table(
                      columnWidths: const
                      {
                        0: FlexColumnWidth(1),
                        1:FlexColumnWidth(2)
                      },
                      border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade100,
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Type"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                book.category,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade100,
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Language"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                book.language,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade100,
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Condition"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                book.condition,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      book.description,
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(buttoncolor: Colors.grey.shade900, onTap: (){

          context.read<BookDetialsBloc>().add(ChatButtonPressedEvent(book: book));


        }, borderRadius: 7,height: 40,child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(CupertinoIcons.chat_bubble,color: Colors.white,),const SizedBox(width: 8,),Text('Chat',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white))],)),
      ),
    );
  }
}
