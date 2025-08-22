import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evenedge/utils/currency_input_formatter.dart';

void main() {
  group('CurrencyInputFormatter Tests', () {
    late CurrencyInputFormatter formatter;

    setUp(() {
      formatter = CurrencyInputFormatter();
    });

    group('Valid Input Tests', () {
      test('allows empty input', () {
        const oldValue = TextEditingValue(text: '');
        const newValue = TextEditingValue(text: '');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals(''));
      });

      test('allows whole numbers', () {
        const oldValue = TextEditingValue(text: '');
        const newValue = TextEditingValue(text: '123');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123'));
      });

      test('allows single decimal place', () {
        const oldValue = TextEditingValue(text: '123');
        const newValue = TextEditingValue(text: '123.5');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.5'));
      });

      test('allows two decimal places', () {
        const oldValue = TextEditingValue(text: '123.5');
        const newValue = TextEditingValue(text: '123.50');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.50'));
      });

      test('allows zero values', () {
        const oldValue = TextEditingValue(text: '');
        const newValue = TextEditingValue(text: '0');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0'));
      });

      test('allows decimal point without digits after', () {
        const oldValue = TextEditingValue(text: '123');
        const newValue = TextEditingValue(text: '123.');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.'));
      });
    });

    group('Invalid Input Tests', () {
      test('rejects more than two decimal places', () {
        const oldValue = TextEditingValue(text: '123.50');
        const newValue = TextEditingValue(text: '123.501');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.50'));
      });

      test('rejects letters', () {
        const oldValue = TextEditingValue(text: '123');
        const newValue = TextEditingValue(text: '123a');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123'));
      });

      test('rejects special characters', () {
        const oldValue = TextEditingValue(text: '123');
        const newValue = TextEditingValue(text: '123!');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123'));
      });

      test('rejects multiple decimal points', () {
        const oldValue = TextEditingValue(text: '123.5');
        const newValue = TextEditingValue(text: '123.5.0');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.5'));
      });

      test('rejects negative numbers', () {
        const oldValue = TextEditingValue(text: '');
        const newValue = TextEditingValue(text: '-123');

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals(''));
      });
    });
  });

  group('validateCurrencyInput Tests', () {
    group('Valid Input Tests', () {
      test('accepts valid whole numbers', () {
        final result = validateCurrencyInput('123', 'Test Field');
        expect(result, isNull);
      });

      test('accepts valid decimal numbers', () {
        final result = validateCurrencyInput('123.45', 'Test Field');
        expect(result, isNull);
      });

      test('accepts zero', () {
        final result = validateCurrencyInput('0', 'Test Field');
        expect(result, isNull);
      });

      test('accepts zero with decimals', () {
        final result = validateCurrencyInput('0.00', 'Test Field');
        expect(result, isNull);
      });

      test('accepts single decimal place', () {
        final result = validateCurrencyInput('123.5', 'Test Field');
        expect(result, isNull);
      });
    });

    group('Invalid Input Tests', () {
      test('rejects empty input', () {
        final result = validateCurrencyInput('', 'Test Field');
        expect(result, equals('Test Field is required'));
      });

      test('rejects null input', () {
        final result = validateCurrencyInput(null, 'Test Field');
        expect(result, equals('Test Field is required'));
      });

      test('rejects non-numeric input', () {
        final result = validateCurrencyInput('abc', 'Test Field');
        expect(result, equals('Please enter a valid amount'));
      });

      test('rejects negative numbers', () {
        final result = validateCurrencyInput('-123', 'Test Field');
        expect(result, equals('Amount cannot be negative'));
      });

      test('rejects more than two decimal places', () {
        final result = validateCurrencyInput('123.456', 'Test Field');
        expect(result, equals('Maximum 2 decimal places allowed'));
      });

      test('rejects mixed text and numbers', () {
        final result = validateCurrencyInput('123abc', 'Test Field');
        expect(result, equals('Please enter a valid amount'));
      });
    });
  });

  group('Helper Function Tests', () {
    group('formatCurrencyValue Tests', () {
      test('formats whole numbers with two decimal places', () {
        final result = formatCurrencyValue(123);
        expect(result, equals('123.00'));
      });

      test('formats decimal numbers to two decimal places', () {
        final result = formatCurrencyValue(123.5);
        expect(result, equals('123.50'));
      });

      test('rounds to two decimal places', () {
        final result = formatCurrencyValue(123.456);
        expect(result, equals('123.46'));
      });
    });

    group('ensureTwoDecimalPlaces Tests', () {
      test('formats empty string to 0.00', () {
        final result = ensureTwoDecimalPlaces('');
        expect(result, equals('0.00'));
      });

      test('formats whole numbers', () {
        final result = ensureTwoDecimalPlaces('123');
        expect(result, equals('123.00'));
      });

      test('formats single decimal place', () {
        final result = ensureTwoDecimalPlaces('123.5');
        expect(result, equals('123.50'));
      });

      test('handles invalid input', () {
        final result = ensureTwoDecimalPlaces('abc');
        expect(result, equals('0.00'));
      });
    });
  });
}
