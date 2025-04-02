import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  try {
    // Print response details for debugging
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    // Check if response body is empty
    if (response.body.isEmpty) {
      showSnackbar(context, "Unexpected empty response from server.");
      return;
    }

    // Try parsing the response body as JSON
    Map<String, dynamic> responseBody;
    try {
      responseBody = json.decode(response.body);
    } catch (e) {
      showSnackbar(context, "Invalid response format: ${response.body}");
      return;
    }

    // Handle different status codes
    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess();
        break;
      case 400:
        showSnackbar(context, responseBody['msg'] ?? "Bad Request");
        break;
      case 500:
        showSnackbar(context, responseBody['error'] ?? "Server error. Please try again later.");
        break;
      default:
        showSnackbar(context, "Unexpected Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    showSnackbar(context, "Error processing response: ${e.toString()}");
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
