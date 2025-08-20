import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cached_network_image/cached_network_image.dart';
class BookContainer extends StatelessWidget {
  String imagepath;
  String price;
  String title;
  String location;

  BookContainer({super.key,required this.imagepath,required this.price,required this.title,required this.location});

  @override
  Widget build(BuildContext context) {
    String imageurl="${dotenv.get('imagefetchurl')}${imagepath}";
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
         borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.black26)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: imageurl,height: 150,width: 150,fit: BoxFit.fill,errorWidget: (context,_,stacktrace){
              return Container(color: Colors.purple.shade50,height: 150,width: 150,);

            },),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(price,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(title,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(location,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12),),
            ),
      
      
      
          ],
        ),
      ),
    );
  }
}
