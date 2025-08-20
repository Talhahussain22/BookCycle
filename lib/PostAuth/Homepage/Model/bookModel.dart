
class BookModel
{
  String bookid;
  String imagepath;
  String condition;
  String category;
  String language;
  String title;
  String description;
  String price;
  String location;
  String ownerid;
  dynamic lat;
  dynamic lon;
  String status;
  
  BookModel({required this.bookid,required this.imagepath,required this.condition,required this.category,required this.language,required this.title,required this.description,required this.price,required this.location,required this.ownerid,required this.lat,required this.lon,required this.status});
  
  factory BookModel.fromJson(Map<String,dynamic> data){
    return BookModel(bookid: data['bookid'],imagepath: data['imagepath'], condition: data['condition'], category: data['category'], language: data['language'], title: data['title'], description: data['description'], price: data['price'], location: data['address'], ownerid: data['ownerid'],lat: data['latitude'], lon: data['longitude'], status: data['status']);
  }
}