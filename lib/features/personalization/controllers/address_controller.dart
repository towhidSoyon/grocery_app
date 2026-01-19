import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/models/address_model.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController{
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());


  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async{
    try{
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((address) => address.selectedAddress,orElse: () => AddressModel.empty());
      return addresses;

    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async{
    try{

      Get.defaultDialog(
        title: '',
        onWillPop: () async{return false;},
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const UCircularLoader(),
      );

      // Clear the "selected" field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }
      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected Address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);

      Get.back();
    }catch(e){
      Get.back();
      UHelperFunctions.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  /// Add New Address Method
  Future addNewAddress() async{
    try{
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Storing Address...', UImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        return ;
      }

      // Form Validation
      if(!addressFormKey.currentState!.validate()){
        UFullScreenLoader.stopLoading();
        return ;
      }

      // Save Address Data
      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          dateTime: DateTime.now(),
          selectedAddress: true
      );
      final id = await addressRepository.addAddress(address);

      // Update Selected Address status
      address.id = id;
      selectAddress(address);

      // Remove Loader
      UFullScreenLoader.stopLoading();

      // show Success message
      UHelperFunctions.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
      Navigator.of(Get.context!).pop();

    }catch(e){
      UFullScreenLoader.stopLoading();
      UHelperFunctions.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  /// Show Addresses  ModalBottomSheet at checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(USizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const USectionHeading(title: 'Select Address'),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (context, snapshot) {
                /// helper Function to handle error, empty and loader
                final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(widget != null) return widget;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => USingleAddress(
                    address: snapshot.data![index],
                    onTap: () async{
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
  /// Function to reset form fields
  resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}