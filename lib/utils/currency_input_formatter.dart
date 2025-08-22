import 'package:flutter/services.dart';

/// A TextInputFormatter that only allows valid currency input with max 2 decimal places
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow empty input
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Only allow digits, decimal point, and one decimal point max
    final RegExp regex = RegExp(r'^\d*\.?\d{0,2}$');

    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    // If the new value doesn't match, return the old value
    return oldValue;
  }
}

/// Validation function for currency input
String? validateCurrencyInput(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName is required';
  }

  // Parse as double to check if it's a valid number
  final double? parsedValue = double.tryParse(value);
  if (parsedValue == null) {
    return 'Please enter a valid amount';
  }

  // Check if it's negative
  if (parsedValue < 0) {
    return 'Amount cannot be negative';
  }

  // Check decimal places
  final parts = value.split('.');
  if (parts.length > 1 && parts[1].length > 2) {
    return 'Maximum 2 decimal places allowed';
  }

  return null; // Valid input
}

/// Helper function to format currency value for display
String formatCurrencyValue(double value) {
  return value.toStringAsFixed(2);
}

/// Helper function to ensure value has exactly 2 decimal places when needed
String ensureTwoDecimalPlaces(String value) {
  if (value.isEmpty) return '0.00';

  final double? parsedValue = double.tryParse(value);
  if (parsedValue == null) return '0.00';

  return parsedValue.toStringAsFixed(2);
}
