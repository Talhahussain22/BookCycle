import 'package:bookcycle/Authentication/components/custom_textfield.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/screen/book_details.dart';
import 'package:bookcycle/PostAuth/SearchPage/bloc/search_bloc.dart';
import 'package:bookcycle/consts/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    controller = TextEditingController();
    Future.delayed(const Duration(milliseconds: 200), () {

      if (mounted) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Column(
        children: [
          const SizedBox(height: 30,),
            Row(
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(CupertinoIcons.back,color: Colors.black,)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomTextField(

                      onchanged: (String query){
                        context.read<SearchBloc>().add(OnChangedInSearch(query: query));
                      },
                      hintext: 'Search Book',
                      controller: controller,
                      focusNode: _focusNode,
                      validator: fieldValidator,
                      color: Colors.white38,
                      borderColor: Colors.blue.shade800,
                      hintextcolor: Colors.black54,
                      textColor: Colors.black,
                      borderRadius: 8,
                      horizontalpadding: 15,
                      verticalpadding: 0,
                    ),
                  ),
                ),
              ],
            ),
          Expanded(
            child: BlocBuilder<SearchBloc,SearchState>(
              builder: (context,state) {
                if(state is SearchLoadedState)
                  {
                    final books=state.books;

                    return ListView.builder(itemCount:books.length ,itemBuilder: (context,index){

                      final book=books[index];
                      return Column(
                        children: [
                          Divider(color: Colors.black26,indent: 10,endIndent: 10,),
                          const SizedBox(height: 30,),

                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(book: book)));
                      },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 10,),
                                    Icon(CupertinoIcons.search,color: Colors.black54,size: 16,),
                                    const SizedBox(width: 15,),
                                    Text(book.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(CupertinoIcons.arrow_up_right,color: Colors.grey.shade700,),
                                ),

                              ],
                            ),
                          ),

                        ],
                      );
                    });

                  }
                else{
                  return SizedBox();
                }
              }
            ),
          ),
        ],
      )
    );
  }
}
