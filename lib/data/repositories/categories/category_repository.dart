import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/data/services/cloudinary_services.dart';
import 'package:grocery_app/utils/constants/keys.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_category_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/firebase_storage_services.dart';
import 'package:dio/dio.dart' as dio;

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());


  @override
  void onInit() {
    //uploadDummyData(HkDummyData.categories);
    super.onInit();
  }

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async{
    try{

      final snapshot = await _db.collection("Category").get();
      if(snapshot.docs.isNotEmpty){
        final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
        return list;
      }

      return [];

    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try{

      final snapshot = await _db.collection("Category").where('ParentId',isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e),).toList();
      return result;

    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Upload Categories to the Cloud Firestore
  Future<void> uploadDummyCategories(List<CategoryModel> categories) async{
    try{
      // Upload all categories along with their image
      final storage = Get.put(UFirebaseStorageService());

      // load through each category
      for(var category in categories){
        /*// Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and get its url
        final url = await storage.uploadImageData('Category', file, category.name);

        // Assign url to Category.image attribute
        category.image = url;*/

        File image = await UHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(image, UKeys.categoryFolder);
        if(response.statusCode == 200){
          category.image = response.data['url'];
        }

        // Storage Category in Firestore
        await _db.collection('Category').doc(category.id).set(category.toJson());

      }
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch (e, stack) {
      print("🔥 REAL ERROR: $e");
      print(stack);
      rethrow;
    }
  }

  Future<void> uploadDummyProductCategory(List<ProductCategoryModel> productCategories) async{
    try{
      for(var productCategory in productCategories){

        await _db.collection("ProductCategory").doc().set(productCategory.toJson());

      }
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadDummyBrandCategory(List<BrandCategoryModel> brandCategories) async{
    try{
      for(var brandCategory in brandCategories){
        await _db.collection("BrandCategory").doc().set(brandCategory.toJson());
      }
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

}