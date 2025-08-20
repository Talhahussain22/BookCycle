import 'package:bookcycle/PostAuth/BookDetailPage/screen/book_details.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:bookcycle/PostAuth/Homepage/bloc/homepage_bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/components/product_display_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Homepage extends StatefulWidget {


  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    context.read<HomepageBloc>().add(getHomepageDataEvent());
    super.initState();
  }
  List<BookModel>? recentBooks;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc,HomepageState>(

      builder: (context,state) {

        if(state is HomepageErrorState)
          {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Unable to fetch data due to ${state.error}'),
                    InkWell(onTap: (){
                      context.read<HomepageBloc>().add(getHomepageDataEvent());
                    },child: Text('Reload',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),textAlign: TextAlign.center,))
                  ],
                ),
              ),
            );
          }
        if(state is HomepageLoadingState)
          {
            return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,));
          }
        if(state is HomepageLoadedState)
        {
          recentBooks=state.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Icon(CupertinoIcons.search, color: Colors.black, size: 16),
                          const SizedBox(width: 20),
                          Text(
                            'Search Book',
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                        alignment: Alignment.center,
                        children: [Image.asset('assets/images/gptbook.png',height: 150,width: double.maxFinite,
                          fit: BoxFit.fitWidth,),
                          Container(
                            width: double.maxFinite,
                            height: 150,
                            color: Colors.black.withOpacity(0.3), // dark overlay
                          ),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: 'TOP ',style: TextStyle(fontSize: 20,color: Colors.white),),
                                TextSpan(text: 'fiction ',style: TextStyle(fontSize: 20,fontFamily: 'Gravitas')),
                                TextSpan(text: 'books',style: TextStyle(fontSize: 20,))
                              ]
                          ))]
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('TOP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: 5,itemBuilder: (context,index){
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BookContainer(imagepath: 'images/book1.jpg', price: "200RS", title: "Fourty Rules of Love", location: "Gulistan-e-johar block 8 Karachi")
                    );
                  }),
                ),

                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Recently added',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: recentBooks?.length,itemBuilder: (context,index){

                    final item=recentBooks![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(book: item)));
                      },child: BookContainer(imagepath: item.imagepath, price: item.price, title: item.title, location: item.location)),
                    );
                  }),
                ),
              ],
            ),
          );
        }
        else
          {
            return Container();
          }

      }
    );
  }
}
