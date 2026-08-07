import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopease/controller/profile_controller.dart';
import 'package:shopease/widgets/button_widget.dart';

import '../controller/edit_profile_controller.dart';
// import '../services/profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController controller = Get.put(EditProfileController());
  static const Color _primaryColor = Color(0xFF6D28FF);

  bool _isEditingAddress = false;

  String get fullAddress {
    final addressParts = [
      controller.addressLine1Controller.text.trim(),
      controller.addressLine2Controller.text.trim(),
      controller.cityController.text.trim(),
      controller.stateController.text.trim(),
      controller.zipCodeController.text.trim(),
      controller.countryController.text.trim(),
    ];

    return addressParts.where((part) => part.isNotEmpty).join(', ');
  }

  Future<void> _showImageOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);

        return Obx(
          () => SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'change_profile_picture'.tr,
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
                    title: Text('take_photo'.tr),
                    onTap: () {
                      Navigator.pop(sheetContext, ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library_outlined,
                      color: _primaryColor,
                    ),
                    title: Text('choose_gallery'.tr),
                    onTap: () {
                      Navigator.pop(sheetContext, ImageSource.gallery);
                    },
                  ),
                  if (controller.selectedImage.value != null)
                    ListTile(
                      leading: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                      title: Text(
                        'remove_selected_photo'.tr,
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        Navigator.pop(sheetContext);

                        controller.removeSelectedImage();
                      },
                    ),
                  ListTile(
                    leading: Icon(
                      Icons.close_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    title: Text('cancel'.tr),
                    onTap: () {
                      Navigator.pop(sheetContext);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (source == null) {
      return;
    }

    await controller.pickImage(source);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => PopScope(
        canPop: !controller.isSaving.value,
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: controller.isSaving.value
                  ? null
                  : () {
                      if (Get.isRegistered<ProfileController>()) {
                        Get.find<ProfileController>().loadProfile();
                      }
                      Get.back();
                    },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              'edit_profile'.tr,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: controller.isLoadingProfile.value
                ? const Center(child: CircularProgressIndicator())
                : controller.errorMessage.value != null
                ? _ProfileErrorState(
                    message: controller.errorMessage.value!,
                    onRetry: controller.loadProfile,
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final isCompact = constraints.maxWidth < 380;

                      final horizontalPadding = constraints.maxWidth < 700
                          ? 18.0
                          : 32.0;

                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          16,
                          horizontalPadding,
                          32,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 720),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildProfilePhoto(context, isCompact),
                                  const SizedBox(height: 30),
                                  _ProfileFieldLabel(
                                    label: 'name'.tr,
                                    child: TextFormField(
                                      controller: controller.nameController,
                                      enabled: !controller.isSaving.value,
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      autofillHints: const [AutofillHints.name],
                                      validator: controller.validateName,
                                      decoration: InputDecoration(
                                        hintText: 'enter_name'.tr,
                                        prefixIcon: const Icon(
                                          Icons.person_outline_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  _ProfileFieldLabel(
                                    label: 'email'.tr,
                                    child: TextFormField(
                                      controller: controller.emailController,
                                      enabled: !controller.isSaving.value,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      autofillHints: const [
                                        AutofillHints.email,
                                      ],
                                      validator: controller.validateEmail,
                                      decoration: InputDecoration(
                                        hintText: 'enter_email'.tr,
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  _ProfileFieldLabel(
                                    label: 'phone_number'.tr,
                                    child: TextFormField(
                                      controller: controller.phoneController,
                                      enabled: !controller.isSaving.value,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      autofillHints: const [
                                        AutofillHints.telephoneNumber,
                                      ],
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      validator: controller.validatePhone,
                                      decoration: InputDecoration(
                                        hintText: 'enter_phone'.tr,
                                        prefixIcon: const Icon(
                                          Icons.phone_outlined,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  _ProfileFieldLabel(
                                    label: 'address'.tr,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: controller.isSaving.value
                                              ? null
                                              : () {
                                                  setState(() {
                                                    _isEditingAddress =
                                                        !_isEditingAddress;
                                                  });
                                                },
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.location_on_outlined,
                                              ),
                                              suffixIcon: AnimatedRotation(
                                                turns: _isEditingAddress
                                                    ? 0.5
                                                    : 0,
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                child: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              fullAddress.isEmpty
                                                  ? 'no_address_added'.tr
                                                  : fullAddress,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                            ),
                                          ),
                                        ),

                                        AnimatedCrossFade(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          crossFadeState: _isEditingAddress
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          firstChild: const SizedBox.shrink(),
                                          secondChild: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 22,
                                            ),
                                            child: Column(
                                              children: [
                                                _ProfileFieldLabel(
                                                  label: 'address_line_1'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .addressLine1Controller,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    validator: controller
                                                        .validateAddressLine1,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'street_address_hint'
                                                              .tr,
                                                      prefixIcon: const Icon(
                                                        Icons.home_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 22),

                                                _ProfileFieldLabel(
                                                  label: 'address_line_2'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .addressLine2Controller,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'apartment_hint'.tr,
                                                      prefixIcon: const Icon(
                                                        Icons
                                                            .alt_route_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 22),

                                                _ProfileFieldLabel(
                                                  label: 'city'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .cityController,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    validator:
                                                        controller.validateCity,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: 'enter_city'.tr,
                                                      prefixIcon: const Icon(
                                                        Icons
                                                            .location_city_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 22),

                                                _ProfileFieldLabel(
                                                  label: 'state_province'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .stateController,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    validator: controller
                                                        .validateState,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'enter_state'.tr,
                                                      prefixIcon: const Icon(
                                                        Icons.map_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 22),

                                                _ProfileFieldLabel(
                                                  label: 'zip_postal_code'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .zipCodeController,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: controller
                                                        .validateZipCode,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: 'enter_zip'.tr,
                                                      prefixIcon: const Icon(
                                                        Icons.pin_drop_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 22),

                                                _ProfileFieldLabel(
                                                  label: 'country'.tr,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .countryController,
                                                    enabled: !controller
                                                        .isSaving
                                                        .value,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    validator: controller
                                                        .validateCountry,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'enter_country'.tr,
                                                      prefixIcon: const Icon(
                                                        Icons.flag_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  ButtonWidget(
                                    buttonText: controller.isSaving.value
                                        ? 'saving'.tr
                                        : 'save_changes'.tr,
                                    backgroundColor: _primaryColor,
                                    color: Colors.white,
                                    onPressed: controller.isSaving.value
                                        ? null
                                        : () async {
                                            await controller.saveProfile();

                                            if (!mounted) return;

                                            setState(() {
                                              _isEditingAddress = false;
                                            });
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
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context, bool isCompact) {
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
                  onTap: controller.isSaving.value ? null : _showImageOptions,
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    backgroundImage: controller.selectedImageBytes.value == null
                        ? null
                        : MemoryImage(controller.selectedImageBytes.value!),
                    child: controller.selectedImageBytes.value == null
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
                    onPressed: controller.isSaving.value
                        ? null
                        : _showImageOptions,
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
            onPressed: controller.isSaving.value ? null : _showImageOptions,
            child: Text(
              'change_photo'.tr,
              style: const TextStyle(fontWeight: FontWeight.w700),
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

  const _ProfileFieldLabel({required this.label, required this.child});

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

  const _ProfileErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRetry,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
              label: Text('try_again_caps'.tr),
            ),
          ),
        ],
      ),
    );
  }
}
