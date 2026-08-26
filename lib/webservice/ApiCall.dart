
import 'dart:convert';
import 'dart:io';
import 'package:canteen_bite_mobile/webservice/response/InitResponse.dart';
import 'package:canteen_bite_mobile/webservice/response/OTPAuthenticateResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/GlobalData.dart';
import '../utils/network/NetworkException.dart';
import '../utils/network/NetworkUtil.dart';



class ApiCall {
  final String BASEURL = "http://10.0.2.2:5123/api/";
  final String BASEURL_GOOGLE_API = "https://maps.googleapis.com/maps/api/";

  Future<dynamic> callAPI(String url, Map<String, dynamic> request) async {

    try {

      if(await NetworkUtil.isConnected()){

        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json'
        };

        headers.addIf(GlobalData.localDataStore.getAuthToken()!.isNotEmpty, "Authorization", "Bearer ${GlobalData.localDataStore.getAuthToken()}");

        printRequest(url, request);

        final response = await http.post(Uri.parse("$BASEURL$url"),
            headers: headers,
            body: jsonEncode(request));

        dynamic responseJson = jsonDecode(response.body);
         printResponse(url, responseJson);
        return responseJson;

      } else {
        throw NetworkException();
      }

    } on NetworkException catch(networkException) {
      rethrow;
    } on Exception {
      throw Exception("Some Error Occurred.");
    }

  }
  Future<dynamic> callAPIWithFile(String url, Map<String, dynamic> request,
      String keyToAddFile, File? file) async
  {
    try {
      if (await NetworkUtil.isConnected()) {

        Map<String, String> headers = {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data'
        };

        headers.addIf(GlobalData.localDataStore.getAuthToken()!.isNotEmpty, "Authorization", "Bearer ${GlobalData.localDataStore.getAuthToken()}");

        printRequest(url, request);
        int fileSize = await file!.length();
        debugPrint('The file size is: $fileSize bytes.');


        var multiPartAPiRequest = http.MultipartRequest(
            'POST', Uri.parse("$BASEURL$url"));

        // Add headers
        multiPartAPiRequest.headers.addAll(headers);

         request.forEach((key, value) {
          multiPartAPiRequest.fields[key] = value.toString();
        });

        File? photoFile = await GlobalData.copyFileToUploadableLocation(
            file.path);

        if (photoFile != null) {
          print("photo file is ${photoFile}");
          multiPartAPiRequest.files.add(
              await http.MultipartFile.fromPath(
                keyToAddFile,
                photoFile.path,
                contentType: MediaType('image', '*'),
              )
          );
        }
        final responseStream = await multiPartAPiRequest.send();

        final responseBody = await responseStream.stream.bytesToString();
        dynamic responseJson = jsonDecode(responseBody);
        printResponse(url,responseJson);

        return responseJson;
      } else {
        throw NetworkException();
      }
    } on NetworkException catch (networkException) {
      rethrow;
    } on Exception catch (e) {
      throw Exception("Some Error Occurred.");
    }
  }

  Future<void> printRequest(String url, Map<String, dynamic> request) async {
    if (kDebugMode) {

      print("APi URL is $BASEURL$url");
      print('$url : Request is ${jsonEncode(request)}');
      if(GlobalData.localDataStore.getAuthToken()!.isNotEmpty){
        print('AuthToken is ${GlobalData.localDataStore.getAuthToken()}');
      }
    }
  }

  Future<void> printResponse(String url, dynamic responseJson) async {
    if (kDebugMode) {
      print("APi URL is $BASEURL$url");
      print("$url : Response is $responseJson");
    }
  }

  Future<String> sendOtp (Map<String, dynamic> request) async {
    var response = await callAPI(("login/send-otp"), request);
    return response['data']['code'];
    }
  Future<OTPAuthenticateResponse> authenticateOTP (Map<String, dynamic> request) async {
    var response = await callAPI(("login/verify-otp"), request);
    return (OTPAuthenticateResponse.fromJson(response));
  }

  Future<dynamic> profile (Map<String, dynamic> request) async {
    var response = await callAPI(("profile"), request);
    return response['data'];
  }
  Future<InitResponse> initData (Map<String, dynamic> request) async {
    var response = await callAPI(("init"), request);
    return(InitResponse.fromJson(response)) ;
  }
}





