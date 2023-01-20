
import 'dart:convert';

import 'package:http/http.dart' as http;

class API{

  Future<List?> getProducts() async {

    List products = [];

    try{
      final data = await http.get(Uri.parse("https://dummyjson.com/products"));

        if(data.statusCode == 200){
          print(data.statusCode);
          products = await jsonDecode(data.body)["products"];
          return products;
        } else {
          print(data.statusCode);
          print(data.body);
          return products;
        }

    }catch(e){
      print("getProducts error $e");
      return products;
    }
    // print(products.runtimeType);
    // print(products);
    // return products;
  }

}