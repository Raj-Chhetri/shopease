import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shopease/models/update_profile_model.dart';
import 'package:shopease/routes/app_routes.dart';
import 'package:shopease/services/profile_service.dart';

class ProfileController extends GetxController {
 final  ProfileService _profileservice = ProfileService();
 final profile=UpdateProfileModel(success: false, message: null, data: null).obs;
 final  isLoading=false.obs;
 final errorMessage = RxnString();
 final isLoggingOut = false.obs;//for logout

@override
  void onInit() {
  super.onInit();
  loadProfile();
  }

Future <void>loadProfile()async{
  try{
    isLoading(true);
    profile.value= await _profileservice.getProfile();

  }
  catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } 
  finally{
    isLoading(false);
  }
}
  String get userName => profile.value?.data?.name ?? '';

  String get userEmail => profile.value?.data?.email ?? '';

  //logout function

  Future<void> logout() async {
  try {
    isLoggingOut(true);

    await _profileservice.logout();

    Get.offAllNamed(AppRoutes.login);
  } catch (e) {
    Get.snackbar(
      'Logout',
      e.toString().replaceFirst('Exception: ', ''),
    );
  } finally {
    isLoggingOut(false);
  }
}
}