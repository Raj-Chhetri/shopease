import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopease/models/update_profile_model.dart' as update_profile;
import 'package:shopease/services/profile_service.dart';

class EditProfileController extends GetxController {
  EditProfileController({ProfileService? profileService})
    : _profileService = profileService ?? ProfileService();

  static const Color primaryColor = Color(0xFF6D28FF);

  final ProfileService _profileService;
  final ImagePicker _imagePicker = ImagePicker();

  //Form Key
  final formKey = GlobalKey<FormState>();

  // Profile Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // final dateOfBirthController = TextEditingController();
  // final addressController = TextEditingController();

  // Address controllers
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();

  //Loading States
  final isLoadingProfile = false.obs;
  final isSaving = false.obs;

  //Error Message
  final errorMessage = RxnString();

  // final selectedGender = RxnString();

  //Selected image
  final selectedImage = Rxn<XFile>();
  final selectedImageBytes = Rxn<Uint8List>();

  final addressId = RxnInt();

  String _originalAddressLine1 = '';
  String _originalAddressLine2 = '';
  String _originalCity = '';
  String _originalState = '';
  String _originalZipCode = '';
  String _originalCountry = '';

  // final genderOptions = const ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoadingProfile.value = true;
    errorMessage.value = null;

    try {
      await _loadProfileInformation();
      await _loadAddressInformation();
    } catch (error) {
      errorMessage.value = _cleanErrorMessage(
        error,
        fallback: 'Unable to load your profile. Please try again.',
      );
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> _loadProfileInformation() async {
    final profileResponse = await _profileService.getProfile();

    _fillControllers(profileResponse);
  }

  Future<void> _loadAddressInformation() async {
    final addressResponse = await _profileService.getAddresses();

    if (addressResponse.data.isEmpty) {
      addressId.value = null;
      _clearAddressControllers();
      return;
    }

    // You currently need only one address,
    // so the first address is selected.
    final address = addressResponse.data.reduce(
      (current, next) => (next.id ?? 0) > (current.id ?? 0) ? next : current,
    );

    addressId.value = address.id;

    addressLine1Controller.text = address.addressLine1 ?? '';
    addressLine2Controller.text = address.addressLine2 ?? '';
    cityController.text = address.city ?? '';
    stateController.text = address.state ?? '';
    zipCodeController.text = address.zipCode ?? '';
    countryController.text = address.country ?? '';

    _originalAddressLine1 = address.addressLine1 ?? '';
    _originalAddressLine2 = address.addressLine2 ?? '';
    _originalCity = address.city ?? '';
    _originalState = address.state ?? '';
    _originalZipCode = address.zipCode ?? '';
    _originalCountry = address.country ?? '';
  }

  void _fillControllers(update_profile.UpdateProfileModel profileResponse) {
    final profile = profileResponse.data;

    if (profile == null) return;

    nameController.text = profile.name ?? '';
    emailController.text = profile.email ?? '';
    phoneController.text = profile.phone ?? '';
  }

  void _clearAddressControllers() {
    addressLine1Controller.clear();
    addressLine2Controller.clear();
    cityController.clear();
    stateController.clear();
    zipCodeController.clear();
    countryController.clear();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image == null) return;

      selectedImage.value = image;
      selectedImageBytes.value = await image.readAsBytes();
    } catch (_) {
      Get.snackbar(
        'Unable to select image',
        'Please check the camera or photo permissions.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void removeSelectedImage() {
    selectedImage.value = null;
    selectedImageBytes.value = null;
  }

  Future<void> saveProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    isSaving.value = true;
    errorMessage.value = null;

    try {
      final updatedProfile = await _profileService.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        image: selectedImage.value,
      );

      _fillControllers(updatedProfile);

      if (_hasAddressInput() && hasAddressChanged) {
        final createdAddress = await _profileService.createAddress(
          addressLine1: addressLine1Controller.text.trim(),
          addressLine2: _nullableText(addressLine2Controller.text),
          city: cityController.text.trim(),
          state: stateController.text.trim(),
          zipCode: zipCodeController.text.trim(),
          country: countryController.text.trim(),
        );

        addressId.value = createdAddress.data?.id;
      }

      selectedImage.value = null;
      selectedImageBytes.value = null;

      Get.snackbar(
        'Profile updated',
        addressId.value == null
            ? 'Your profile was saved successfully.'
            : 'Your profile information was saved successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      final message = _cleanErrorMessage(
        error,
        fallback: 'Unable to save your changes. Please try again.',
      );

      errorMessage.value = message;

      Get.snackbar(
        'Unable to save changes',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  bool _hasAddressInput() {
    return addressLine1Controller.text.trim().isNotEmpty ||
        addressLine2Controller.text.trim().isNotEmpty ||
        cityController.text.trim().isNotEmpty ||
        stateController.text.trim().isNotEmpty ||
        zipCodeController.text.trim().isNotEmpty ||
        countryController.text.trim().isNotEmpty;
  }

  bool get hasAddressChanged {
    return addressLine1Controller.text.trim() != _originalAddressLine1 ||
        addressLine2Controller.text.trim() != _originalAddressLine2 ||
        cityController.text.trim() != _originalCity ||
        stateController.text.trim() != _originalState ||
        zipCodeController.text.trim() != _originalZipCode ||
        countryController.text.trim() != _originalCountry;
  }

  String? _nullableText(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return null;
    }

    return trimmedValue;
  }

  String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Name is required';
    if (name.length < 2) return 'Enter a valid name';
    return null;
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(email)) return 'Enter a valid email address';
    return null;
  }

  String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validateAddressLine1(String? value) {
    final address = value?.trim() ?? '';

    if (address.isEmpty) {
      return 'Address line 1 is required';
    }

    return null;
  }

  String? validateCity(String? value) {
    final city = value?.trim() ?? '';

    if (city.isEmpty) {
      return 'City is required';
    }

    return null;
  }

  String? validateState(String? value) {
    final state = value?.trim() ?? '';

    if (state.isEmpty) {
      return 'State is required';
    }

    return null;
  }

  String? validateZipCode(String? value) {
    final zipCode = value?.trim() ?? '';

    if (zipCode.isEmpty) {
      return 'ZIP code is required';
    }

    return null;
  }

  String? validateCountry(String? value) {
    final country = value?.trim() ?? '';

    if (country.isEmpty) {
      return 'Country is required';
    }

    return null;
  }

  String _cleanErrorMessage(Object error, {required String fallback}) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }

    if (message.isNotEmpty) {
      return message;
    }

    return fallback;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();

    super.onClose();
  }
}
