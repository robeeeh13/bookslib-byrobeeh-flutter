import 'dart:convert';
import 'dart:io';

import 'package:bookslib/constants/error_handling.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/models/product.dart';
import 'package:bookslib/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // SELL BOOK PRODUCT
  void sellProduct({
    required BuildContext context,
    required String productName,
    required String authorName,
    required String publisher,
    required String yearPublished,
    required String description,
    required double price,
    required double quantity,
    required String genre,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // USING CLOUDNIARY TO UPLOAD IMAGES
      final cloudinary = CloudinaryPublic('dgm6wgx8h', 'nq02w8tr');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: productName),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        productName: productName,
        authorName: authorName,
        publisher: publisher,
        yearPublished: yearPublished,
        description: description,
        price: price,
        quantity: quantity,
        genre: genre,
        category: category,
        images: imageUrls,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Produk berhasil ditambahkan');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // GET ALL BOOKS PRODUCT
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-all-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productsList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  // DELETE BOOK PRODUCT
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
