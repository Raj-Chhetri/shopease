import 'package:flutter/material.dart';
import 'package:shopease/services/profile_service.dart';

class AddressSetupScreen extends StatefulWidget {
  const AddressSetupScreen({super.key, required this.onAddressSaved});

  final VoidCallback onAddressSaved;

  @override
  State<AddressSetupScreen> createState() => _AddressSetupScreenState();
}

class _AddressSetupScreenState extends State<AddressSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profileService = ProfileService();

  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController(text: 'Nepal');

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  Future<void> _saveAddress() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(_formKey.currentState?.validate() ?? false) || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await _profileService.createAddress(
        addressLine1: _addressLine1Controller.text.trim(),
        addressLine2: _addressLine2Controller.text.trim().isEmpty
            ? null
            : _addressLine2Controller.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
        country: _countryController.text.trim(),
      );

      if (!mounted) return;
      widget.onAddressSaved();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = error.toString().replaceFirst('Exception: ', '').trim();
      });
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 70,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Set your delivery address',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ShopEase needs one delivery address before you start shopping. You can change it later from Edit Profile.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _field(
                      controller: _addressLine1Controller,
                      label: 'Address line 1',
                      validator: (value) => _required(value, 'Address line 1'),
                      icon: Icons.home_outlined,
                    ),
                    _field(
                      controller: _addressLine2Controller,
                      label: 'Address line 2 (optional)',
                      icon: Icons.apartment_outlined,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _field(
                            controller: _cityController,
                            label: 'City',
                            validator: (value) => _required(value, 'City'),
                            icon: Icons.location_city_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(
                            controller: _stateController,
                            label: 'State / Province',
                            validator: (value) =>
                                _required(value, 'State / Province'),
                            icon: Icons.map_outlined,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _field(
                            controller: _zipCodeController,
                            label: 'ZIP / Postal code',
                            validator: (value) =>
                                _required(value, 'ZIP / Postal code'),
                            icon: Icons.markunread_mailbox_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(
                            controller: _countryController,
                            label: 'Country',
                            validator: (value) => _required(value, 'Country'),
                            icon: Icons.public_outlined,
                          ),
                        ),
                      ],
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ],
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _saveAddress,
                        icon: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check_circle_outline_rounded),
                        label: Text(
                          _isSaving ? 'SAVING ADDRESS...' : 'SAVE AND CONTINUE',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      ),
    );
  }
}
