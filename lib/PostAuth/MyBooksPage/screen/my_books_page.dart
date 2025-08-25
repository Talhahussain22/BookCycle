import 'dart:math' as math;

import 'package:bookcycle/PostAuth/BookDetailPage/screen/book_details.dart';
import 'package:bookcycle/PostAuth/MyBooksPage/bloc/mybooksbloc_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:intl/intl.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  @override
  void initState() {
    final state = context.read<MybooksblocBloc>().state;
    if(state is ! MybooksLoadedState)
      {
        context.read<MybooksblocBloc>().add(MybooksDataFetch());
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final baseurl = dotenv.get('imagefetchurl');
    return BlocConsumer<MybooksblocBloc, MybooksblocState>(
      listener: (context, state) {
        if (state is MybooksErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Center(child: Text(state.error)),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MybooksLoadingState)
          {return Center(child: CircularProgressIndicator());}
        if (state is MybooksLoadedState) {
          final books = state.books;

          return CustomMaterialIndicator(
            onRefresh: () async {
              context.read<MybooksblocBloc>().add(MybooksDataFetch());
              await Future.delayed(Duration(milliseconds: 500));
            },
            backgroundColor: Colors.black,
            indicatorBuilder: (context, controller) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                  value:
                      controller.state.isLoading
                          ? null
                          : math.min(controller.value, 1.0),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 10),
                  child: Text(
                    'My Books',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                books.isEmpty
                    ? Expanded(
                      child: Center(
                        child: Text(
                          'Not listed any book yet!',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0,
                        ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetails(book: book),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: CachedNetworkImage(
                                      imageUrl: baseurl + book.imagepath,
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Price
                                            Text(
                                              book.price,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                  ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade300,
                                                ),
                                                child: Text(
                                                  book.status,
                                                  style: TextStyle(
                                                    color:
                                                        book.status == 'Active'
                                                            ? Colors
                                                                .blue
                                                                .shade700
                                                            : Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Text(
                                          book.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              color: Colors.black87,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Created on ',
                                              style: TextStyle(
                                                fontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              DateFormat.yMMMd().format(
                                                book.createdAt.toDate(),
                                              ),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.blue.shade800,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              book.views.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              book.views > 1 ? 'Views' : 'View',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
