import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/repositories/brand/brand_repository.dart';
import '../../../../data/repositories/product_repository.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/brand_model.dart';
import '../../models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  /// Variables
  RxBool isLoading = false.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final repository = Get.put(BrandRepository());


  @override
  void onInit() {
    //repository.uploadDummyBrands(HkDummyData.brands);
    getFeaturedBrands();
    super.onInit();
  }

  /// Load Brands
  Future<void> getFeaturedBrands() async{
    try{
      // Start Loading
      isLoading.value = true;

      final brands = await repository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false ).take(4));

    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  /// Get Brands for Specific Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try{

      final brands = await repository.getBrandsForCategory(categoryId);
      return brands;

    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async{
    try{
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId,limit: limit);
      return products;
    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

}