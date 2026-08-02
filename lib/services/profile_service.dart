import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/update_profile_model.dart' as profile_model;
import '../models/address_model.dart' as address_model;
import '../models/get_address_model.dart';

class ProfileService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://shopease.sudamhub.com/api',
      headers: {'Accept': 'application/json'},
    ),
  );

  // Get saved login token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    // Change "token" if you stored it with another name
    return prefs.getString('token');
  }

  Future<String> _requireToken() async {
    final token = await getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found');
    }

    return token;
  }

  // Get profile from backend
  Future<profile_model.UpdateProfileModel> getProfile() async {
    try {
      final token = await getToken();

      final response = await dio.get(
        '/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // final data = response.data['data'];

      // final profileData = data['profile'] ?? data['user'] ?? data;

      // return profile_model.UpdateProfileModel.fromJson(profileData);

      return profile_model.UpdateProfileModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (error) {
      print(error.response?.data);

      throw Exception(
        error.response?.data['message'] ?? 'Unable to load profile',
      );
    }
  }

  Future<profile_model.UpdateProfileModel> updateProfile({
    required String name,
    required String email,
    required String phone,
    XFile? image,
  }) async {
    try {
      final token = await getToken();

      final formData = FormData.fromMap({
        '_method': 'PUT',
        'name': name,
        'email': email,
        'phone': phone,

        // 'date_of_birth': profile.dateOfBirth,
        // 'gender': profile.gender,
        // 'address': profile.address,
        if (image != null)
          'avatar': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
      });

      final response = await dio.post(
        '/profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // print(response.data);

      // final data = response.data['data'];
      return profile_model.UpdateProfileModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (error) {
      throw Exception(
        _getErrorMessage(error, fallback: 'Unable to load profile'),
      );
    }
  }

  Future<GetAddressModel> getAddresses() async {
    try {
      final token = await _requireToken();

      final response = await dio.get(
        '/addresses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return GetAddressModel.fromJson(Map<String, dynamic>.from(response.data));
    } on DioException catch (error) {
      throw Exception(
        _getErrorMessage(error, fallback: 'Unable to retrieve address'),
      );
    }
  }

  Future<address_model.CreateAddressModel> createAddress({
    required String addressLine1,
    String? addressLine2,
    required String city,
    required String state,
    required String zipCode,
    required String country,
  }) async {
    try {
      final token = await _requireToken();

      final response = await dio.post(
        '/addresses',
        data: {
          'address_line1': addressLine1,
          'address_line2': addressLine2,
          'city': city,
          'state': state,
          'zip_code': zipCode,
          'country': country,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      return address_model.CreateAddressModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (error) {
      throw Exception(
        _getErrorMessage(error, fallback: 'Unable to create address'),
      );
    }
  }

  String _getErrorMessage(DioException error, {required String fallback}) {
    final responseData = error.response?.data;

    if (responseData is Map) {
      final message = responseData['message'];

      if (message != null) {
        return message.toString();
      }

      final errors = responseData['errors'];

      if (errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;

        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }

        return firstError.toString();
      }
    }

    return fallback;
  }
}
