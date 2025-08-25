import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/BookSoldorDeleteBloc/book_soldor_delete_bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/bloc/book_detials_bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/repository/chatrepo.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/screen/chatpage.dart';
import 'package:bookcycle/PostAuth/Dashboard.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BookDetails extends StatefulWidget {
  BookModel book;
  BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  @override
  void initState() {
    final views=widget.book.views;
    final bookid=widget.book.bookid;
    final uid=FirebaseAuth.instance.currentUser!.uid;
    final ownerid=widget.book.ownerid;
    if(uid!=ownerid)
      {
        context.read<BookDetialsBloc>().add(ViewIncrementEvent(bookid: bookid, views: views));

      }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String imageurl = "${dotenv.get('imagefetchurl')}${widget.book.imagepath}";

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<BookSoldorDeleteBloc,BookSoldOrDeleteState>(
        listener: (context,booksoldstate){
          if(booksoldstate is BookSoldOrDeleteErrorState)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(booksoldstate.error)));
            }
          if(booksoldstate is BookSoldOrDeleteLoadedState)
            {
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Dashboard()), (_)=>true);
            }
        },
        builder: (context,booksoldstate) {
          return BlocConsumer<BookDetialsBloc, BookDetialsState>(
            listener: (context, state) {
              if (state is BookDetailsLoadedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ChatPage(
                          personimagepath: state.data?['imagepath'],
                          personName:
                              '${state.data?['first name']} ${state.data?['last name']}',
                          bookimagepath: widget.book.imagepath,
                          booktitle: widget.book.title,
                          bookprice: widget.book.price,
                          chatdoc: state.chatdoc,
                        ),
                  ),
                );
              }
              if (state is BookDetailsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is BookDetailsLoadingState || booksoldstate is BookSoldOrDeleteLoadingState,
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
                              widget.book.price,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              widget.book.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
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
                                  widget.book.location,
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
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
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
                                        widget.book.category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                        widget.book.language,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                        widget.book.condition,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                              widget.book.description,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            widget.book.ownerid != FirebaseAuth.instance.currentUser!.uid
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    buttoncolor: Colors.grey.shade900,
                    onTap: () {
                      context.read<BookDetialsBloc>().add(
                        ChatButtonPressedEvent(book: widget.book),
                      );
                    },
                    borderRadius: 7,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.chat_bubble, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Chat',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Abel',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : widget.book.status=='Active'?Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttoncolor: Colors.transparent,
                        onTap: () {
                          context.read<BookSoldorDeleteBloc>().add(onBookSoldOrDeleteButtonPressed(status: 'Removed', bookid: widget.book.bookid));
                        },
                        borderRadius: 7,
                        height: 40,
                        bordercolor: Colors.grey.shade900,
                        child: Center(
                          child: Text(
                            'Remove Book',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Abel',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        buttoncolor: Colors.grey.shade900,
                        onTap: () {
                          context.read<BookSoldorDeleteBloc>().add(onBookSoldOrDeleteButtonPressed(status: 'Sold', bookid: widget.book.bookid));

                        },
                        borderRadius: 7,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Mark as sold',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Abel',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ):SizedBox(),
      ),
    );
  }
}
