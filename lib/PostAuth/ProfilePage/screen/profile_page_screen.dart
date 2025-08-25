import 'package:bookcycle/PostAuth/ProfilePage/bloc/profile_page_bloc.dart';
import 'package:bookcycle/PostAuth/ProfilePage/repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfilePageScreen extends StatefulWidget {

  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {



  @override
  void initState() {
    context.read<ProfilePageBloc>().add(GetProfilePageData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final url=dotenv.get('imagefetchurl');
    Map<String,dynamic>? data;
    return BlocBuilder<ProfilePageBloc,ProfilePageState>(
      builder: (context,state){
        if(state is ProfilePageDataFetchedState)
          {
            data=state.data;
          }
        return Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              CircleAvatar(
                radius: 80,
                backgroundImage: data!=null? CachedNetworkImageProvider('${url}${data!['imagepath']}') :null,

              ),
              const SizedBox(height: 10),
              RichText(text: TextSpan(
                children:[
                  TextSpan(text:'${data?['first name']??''} ${data?['last name']??''}',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
                ]
              ))
            ],
          ),
        );
      },

    );
  }
}
