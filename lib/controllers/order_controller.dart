import 'dart:convert';

import 'package:web_app_admin_panel/models/order.dart';
import 'package:http/http.dart' as http;

import '../global_variable.dart';

class OrderController {
  // load orders
  Future<List<OrderModel>> fetchOrders() async {
    try {
      // send an http request to the server to fetch orders from the server
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders'),
        //set headers to specify the content type as json, ensuring proper encoding and communication
        //why: the server expects requests to specify the data format, and in this we are using json format
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      // print(response.body);
      // check if the response is successful, meaning the request was successful and the server returned a 200 status code
      //why: HTTP status code indicates whether the request succeded or failed, 200 means ok
      if (response.statusCode == 200) {
        //decode the json response body into a list of dynamic objects
        //why: the server returns data as json string, so we must convert it to a list of dynamic objects
        List<dynamic> data = jsonDecode(response.body);
        //convert the list of dynamic objects into a list of OrderModel objects
        //why: we need to convert the dynamic objects into a list of OrderModel objects to use them in the app
        List<OrderModel> orders =
            data.map((order) => OrderModel.fromJson(order)).toList();
        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error loading orders:$e');
    }
  }
}