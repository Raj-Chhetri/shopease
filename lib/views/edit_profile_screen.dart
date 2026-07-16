// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shopease/widgets/button_widget.dart';
// import 'package:shopease/widgets/fillUp_widget.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   File? selectedImage;
//   final ImagePicker picker = ImagePicker();

//   Future<void> showImageOptions() async {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (_) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Change Profile Picture",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
//                 ),

//                 const SizedBox(height: 18),

//                 ListTile(
//                   leading: const Icon(
//                     Icons.camera_alt,
//                     color: Color(0xFF6D28FF),
//                   ),
//                   title: const Text("Take Photo"),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),

//                 ListTile(
//                   leading: const Icon(
//                     Icons.photo_library,
//                     color: Color(0xFF6D28FF),
//                   ),
//                   title: const Text("Choose from Gallery"),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),

//                 ListTile(
//                   leading: const Icon(Icons.cancel, color: Colors.red),
//                   title: const Text(
//                     "Cancel",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         title: const Text(
//           "Edit Profile",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //ProfileAvatar
//             Center(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // Handle photo change action
//                         },
//                         child: CircleAvatar(
//                           radius: 75,
//                           backgroundColor: Color(0xFF6D28FF),
//                           child: Icon(
//                             Icons.account_circle_sharp,
//                             size: 150,
//                             color: Color.fromARGB(255, 124, 196, 218),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: 0,
//                         bottom: 5,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF6D28FF),
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 3),
//                           ),
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               showImageOptions();
//                               // Handle camera icon press action
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   InkWell(
//                     onTap: () {
//                       showImageOptions();
//                       // Handle photo change action
//                     },
//                     child: Text(
//                       "Change Photo",
//                       style: TextStyle(
//                         color: Color(0xFF6D28FF),
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
    
//             // Name
//             Gap(12),
    
//             Text(
//               "Name",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             FillupWidget(
//               icon: Icons.person,
//               keyboardType: TextInputType.text,
//               hintText: 'John Doe',
//             ),
    
//             Gap(30),
    
//             //Email
//             Text(
//               "Email",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             Gap(12),
//             FillupWidget(
//               icon: Icons.email,
//               keyboardType: TextInputType.emailAddress,
//               hintText: 'john@gmail.com',
//             ),
    
//             //PhoneNumber
//             Gap(30),
    
//             Text(
//               "Phone Number",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             Gap(8),
//             FillupWidget(
//               icon: Icons.phone,
//               keyboardType: TextInputType.number,
//               hintText: '+977 980000000',
//             ),
    
//             Gap(30),
    
//             //DOB
//             Text(
//               "Date of Birth",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             Gap(8),
//             FillupWidget(
//               icon: Icons.date_range,
//               keyboardType: TextInputType.datetime,
//               hintText: 'Jan 01, 1995',
//             ),
    
//             Gap(30),
    
//             //Gender
//             Text(
//               "Gender",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             Gap(8),
//             FillupWidget(
//               icon: Icons.person,
//               keyboardType: TextInputType.text,
//               hintText: 'Male',
//             ),
    
//             Gap(30),
    
//             //Address
//             Text(
//               "Address",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff5B6475),
//               ),
//             ),
//             Gap(8),
//             FillupWidget(
//               icon: Icons.location_on,
//               keyboardType: TextInputType.text,
//               hintText: 'Pokhara, Kaski',
//             ),
    
//             Gap(30),
    
//             //Button
//             ButtonWidget(
//               buttonText: "Save Changes",
//               backgroundColor: Color(0xFF6D28FF),
//               onPressed: () {},
//               color: Colors.white,
//             ),

//             Gap(10),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopease/widgets/button_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  final TextEditingController _dateOfBirthController =
      TextEditingController();

  final TextEditingController _addressController =
      TextEditingController();

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;

  String? _selectedGender;

  bool _isLoadingProfile = false;
  bool _isSaving = false;

  String? _errorMessage;

  final List<String> _genderOptions = const [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _errorMessage = null;
    });

    try {
      // Backend:
      // GET /api/profile
      //
      // final response = await profileService.getProfile();
      // final profile = response.data['data'];
      //
      // _nameController.text = profile['name'] ?? '';
      // _emailController.text = profile['email'] ?? '';
      // _phoneController.text = profile['phone'] ?? '';
      // _dateOfBirthController.text =
      //     profile['date_of_birth'] ?? '';
      // _addressController.text = profile['address'] ?? '';
      // _selectedGender = profile['gender'];

      await Future<void>.delayed(
        const Duration(milliseconds: 450),
      );

      if (!mounted) return;

      setState(() {
        // Temporary UI data.
        _nameController.text = 'John Doe';
        _emailController.text = 'john@gmail.com';
        _phoneController.text = '9800000000';
        _dateOfBirthController.text = '1995-01-01';
        _addressController.text = 'Pokhara, Kaski';
        _selectedGender = 'Male';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load your profile. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProfile = false;
        });
      }
    }
  }

  Future<void> _showImageOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              4,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Change Profile Picture',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: _primaryColor,
                  ),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.pop(
                      sheetContext,
                      ImageSource.camera,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: _primaryColor,
                  ),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(
                      sheetContext,
                      ImageSource.gallery,
                    );
                  },
                ),
                if (_selectedImage != null)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Remove Selected Photo',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);

                      setState(() {
                        _selectedImage = null;
                        _selectedImageBytes = null;
                      });
                    },
                  ),
                ListTile(
                  leading: Icon(
                    Icons.close_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  title: const Text('Cancel'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) {
      return;
    }

    await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image == null) {
        return;
      }

      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedImage = image;
        _selectedImageBytes = bytes;
      });
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to select image',
        'Please check the camera or photo permissions.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();

    final existingDate = DateTime.tryParse(
      _dateOfBirthController.text.trim(),
    );

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: existingDate ??
          DateTime(
            now.year - 18,
            now.month,
            now.day,
          ),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Select date of birth',
    );

    if (selectedDate == null) {
      return;
    }

    _dateOfBirthController.text = _formatDate(selectedDate);
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Backend:
      // PUT /api/profile
      //
      // Confirm whether the backend expects JSON or multipart.
      // The likely values are:
      //
      // name: _nameController.text.trim()
      // email: _emailController.text.trim()
      // phone: _phoneController.text.trim()
      // date_of_birth: _dateOfBirthController.text.trim()
      // gender: _selectedGender
      // address: _addressController.text.trim()
      // image/avatar: _selectedImage
      //
      // Do not send an image field until its backend key is confirmed.

      await Future<void>.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) return;

      Get.snackbar(
        'Profile updated',
        'Your changes were saved successfully.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        backgroundColor: _primaryColor,
        colorText: Colors.white,
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to save changes',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Name is required';
    }

    if (name.length < 2) {
      return 'Enter a valid name';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) {
      return 'Phone number is required';
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  String? _validateDateOfBirth(String? value) {
    final date = value?.trim() ?? '';

    if (date.isEmpty) {
      return null;
    }

    if (DateTime.tryParse(date) == null) {
      return 'Select a valid date';
    }

    return null;
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_isSaving,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: _isSaving ? null : Get.back,
            tooltip: 'Back',
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
          title: Text(
            'Edit Profile',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: _isLoadingProfile
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _errorMessage != null
                  ? _ProfileErrorState(
                      message: _errorMessage!,
                      onRetry: _loadProfile,
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact =
                            constraints.maxWidth < 380;

                        final horizontalPadding =
                            constraints.maxWidth < 700
                                ? 18.0
                                : 32.0;

                        return SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            16,
                            horizontalPadding,
                            32,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 720,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildProfilePhoto(
                                      context,
                                      isCompact,
                                    ),
                                    const SizedBox(height: 30),
                                    _ProfileFieldLabel(
                                      label: 'Name',
                                      child: TextFormField(
                                        controller:
                                            _nameController,
                                        enabled: !_isSaving,
                                        textInputAction:
                                            TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        autofillHints: const [
                                          AutofillHints.name,
                                        ],
                                        validator: _validateName,
                                        decoration:
                                            const InputDecoration(
                                          hintText: 'Enter your name',
                                          prefixIcon: Icon(
                                            Icons.person_outline_rounded,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    _ProfileFieldLabel(
                                      label: 'Email',
                                      child: TextFormField(
                                        controller:
                                            _emailController,
                                        enabled: !_isSaving,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction:
                                            TextInputAction.next,
                                        autofillHints: const [
                                          AutofillHints.email,
                                        ],
                                        validator: _validateEmail,
                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              'Enter your email address',
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    _ProfileFieldLabel(
                                      label: 'Phone Number',
                                      child: TextFormField(
                                        controller:
                                            _phoneController,
                                        enabled: !_isSaving,
                                        keyboardType:
                                            TextInputType.phone,
                                        textInputAction:
                                            TextInputAction.next,
                                        autofillHints: const [
                                          AutofillHints.telephoneNumber,
                                        ],
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(
                                            10,
                                          ),
                                        ],
                                        validator: _validatePhone,
                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              'Enter your phone number',
                                          prefixIcon: Icon(
                                            Icons.phone_outlined,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    _ProfileFieldLabel(
                                      label: 'Date of Birth',
                                      child: TextFormField(
                                        controller:
                                            _dateOfBirthController,
                                        readOnly: true,
                                        enabled: !_isSaving,
                                        validator:
                                            _validateDateOfBirth,
                                        onTap: _selectDateOfBirth,
                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              'Select your date of birth',
                                          prefixIcon: Icon(
                                            Icons
                                                .calendar_month_outlined,
                                          ),
                                          suffixIcon: Icon(
                                            Icons
                                                .keyboard_arrow_down_rounded,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    _ProfileFieldLabel(
                                      label: 'Gender',
                                      child:
                                          DropdownButtonFormField<String>(
                                        initialValue:
                                            _selectedGender,
                                        decoration:
                                            const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons
                                                .person_search_outlined,
                                          ),
                                          hintText:
                                              'Select your gender',
                                        ),
                                        items: _genderOptions
                                            .map(
                                              (gender) =>
                                                  DropdownMenuItem(
                                                value: gender,
                                                child: Text(gender),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: _isSaving
                                            ? null
                                            : (value) {
                                                setState(() {
                                                  _selectedGender =
                                                      value;
                                                });
                                              },
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    _ProfileFieldLabel(
                                      label: 'Address',
                                      child: TextFormField(
                                        controller:
                                            _addressController,
                                        enabled: !_isSaving,
                                        minLines: 2,
                                        maxLines: 4,
                                        textInputAction:
                                            TextInputAction.done,
                                        textCapitalization:
                                            TextCapitalization
                                                .sentences,
                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              'Enter your address',
                                          alignLabelWithHint: true,
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 44,
                                            ),
                                            child: Icon(
                                              Icons
                                                  .location_on_outlined,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    ButtonWidget(
                                      buttonText: _isSaving
                                          ? 'Saving...'
                                          : 'Save Changes',
                                      backgroundColor:
                                          _primaryColor,
                                      color: Colors.white,
                                      onPressed: _isSaving
                                          ? null
                                          : () async {
                                              await _saveProfile();
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(
    BuildContext context,
    bool isCompact,
  ) {
    final theme = Theme.of(context);
    final radius = isCompact ? 62.0 : 72.0;

    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _isSaving ? null : _showImageOptions,
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor:
                        theme.colorScheme.surfaceContainerHighest,
                    backgroundImage: _selectedImageBytes == null
                        ? null
                        : MemoryImage(_selectedImageBytes!),
                    child: _selectedImageBytes == null
                        ? Icon(
                            Icons.person_rounded,
                            size: radius * 1.25,
                            color: theme.colorScheme.primary,
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: 4,
                child: Material(
                  color: _primaryColor,
                  shape: const CircleBorder(),
                  elevation: 3,
                  child: IconButton(
                    onPressed:
                        _isSaving ? null : _showImageOptions,
                    tooltip: 'Change profile photo',
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: _isSaving ? null : _showImageOptions,
            child: const Text(
              'Change Photo',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileFieldLabel extends StatelessWidget {
  final String label;
  final Widget child;

  const _ProfileFieldLabel({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 9),
        child,
      ],
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ProfileErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRetry,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(height: 140),
          Icon(
            Icons.person_off_outlined,
            size: 68,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 18),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          Center(
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }
}