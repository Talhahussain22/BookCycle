import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bookcycle/services/NetworkServices/network_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupaBaseImages{

  Future<String?> uploadImage(File file) async
  {
    try
        {
          final apikey=dotenv.get('apikey');
          final filePath = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          final uri='${dotenv.get('imageurl')}/$filePath';

          final response=await http.post(Uri.parse(uri),body: await file.readAsBytes(),headers: {
            'Authorization': 'Bearer $apikey',
            'Content-Type': 'image/jpeg',
          });

          if(response.statusCode==200){
            return jsonDecode(response.body)["Key"];

          }
        }catch(e){
      throw e.toString();
    }

  }

}