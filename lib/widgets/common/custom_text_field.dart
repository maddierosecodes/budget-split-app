import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.prefixText,
    this.hintText,
    super.key,
  });

  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  bool _hasBeenValidated = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes for real-time validation only after first validation
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    // Only trigger validation if field has been validated before
    // This prevents validation on first focus/typing
    if (_hasBeenValidated) {
      _fieldKey.currentState?.validate();
    }
  }

  String? _wrappedValidator(String? value) {
    // Mark that validation has occurred
    _hasBeenValidated = true;
    // Call the original validator
    return widget.validator?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: _wrappedValidator,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUnfocus,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixText: widget.prefixText,
        border: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
