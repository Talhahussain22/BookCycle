import 'dart:convert';

import 'package:http/http.dart' as http;
class NetworkServices{

  Future<dynamic> getApiData({required String appUrl,required Map<String,String>? header})async{
    try
        {
          final response=await http.get(Uri.parse(appUrl),headers: header);
          return ReturnResponse(response);
        }catch(e){
          throw e.toString();
    }
  }

  Future PostData(String url,Map<String,dynamic> body,Map<String,String> header) async
  {
    dynamic JsonResponse;
    try
    {

      final response=await http.post(Uri.parse(url),body: jsonEncode(body), headers:header,);

      JsonResponse=ReturnResponse(response);

    }
    catch(e)
    {

      throw e.toString();
    }

    return JsonResponse;
  }

  dynamic ReturnResponse(http.Response response)
  {
    final statuscode=response.statusCode;
    switch(statuscode){
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw 'Unable to Fetch';
      case 404:
        throw 'Unauthorized request';
      default:
        throw 'Unknown error occured';

    }
  }
}