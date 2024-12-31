import 'dart:convert';
import 'package:flutter_rest_api/utils/utils.dart';
import 'package:http/http.dart' as http;

class RestClient {
   Future<bool> productCreateRequest(formData) async {
    var url = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    var postBody = json.encode(formData);
    var postHeader = {'content-type': 'application/json'};

    var response = await http.post(url, headers: postHeader, body: postBody);
    var responseBody = json.decode(response.body);

    if (response.statusCode == 200 && responseBody['status'] == 'success') {
      AppUtils.successToast('Request Success');
      return true;
    } else {
      AppUtils.errorToast('Request failed! Try again');
      return false;
    }
  }

  Future<List> productReadRequest() async {
     var url = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
     var postHeader = {'content-type': 'application/json'};

     var response = await http.get(url, headers: postHeader);
     var responseBody = json.decode(response.body);

     if (response.statusCode == 200 && responseBody['status'] == 'success') {
       AppUtils.successToast('Request Success');
       return responseBody['data'];
     } else {
       AppUtils.errorToast('Request failed! Try again');
       return [];
     }
  }

  Future<bool> deleteProductRequest(String id) async {
     var url = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$id');
     var postHeader = {'content-type': 'application/json'};
     
     var response = await http.get(url, headers: postHeader);
     var responseBody = json.decode(response.body);

     if (response.statusCode == 200 && responseBody['status'] == 'success') {
       AppUtils.successToast('Delete successful!');
       return true;
     } else {
       AppUtils.errorToast('Deletion failed');
       return false;
     }
  }
}
