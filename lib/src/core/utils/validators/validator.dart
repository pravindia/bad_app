/// {@template base_validator}
/// A validator that checks if the value is a valid or not.
/// {@endtemplate}
abstract class Validator<T> {
  /// {@macro base_validator}
  const Validator({required this.message});

  /// A message to show when the value is invalid.
  final String message;

  /// Validates the value.
  /// Returns `true` if the value is valid, `false` otherwise.
  bool isValid(T? value);
}

/// {@template required_validator}
/// Checks if the value is not null or empty.
/// {@endtemplate}
class RequiredValidator extends Validator<String?> {
  /// {@macro required_validator}
  const RequiredValidator({String? message})
      : super(
          message: message ?? "This field is required.",
        );

  @override
  bool isValid(String? value) => value != null && value.isNotEmpty;
}

/// {@template email_validator}
/// Checks if the value is a valid email address.
/// {@endtemplate}
class EmailValidator extends Validator<String?> {
  /// {@macro email_validator}
  const EmailValidator({String? message})
      : super(
          message: message ?? "Please enter a valid email address.",
        );

  @override
  bool isValid(String? value) {
    // Regex to check for valid email address.
    final regex = RegExp(r'\S+@\S+\.\S+');

    return value != null && regex.hasMatch(value);
  }
}

/// {@template min_value_validator}
/// This validator check if the value is greater than or equal to [minValue].
/// {@endtemplate}
class MinimumValueValidator extends Validator<String?> {
  /// {@macro min_value_validator}
  const MinimumValueValidator({
    required this.minValue,
    String? message,
  }) : super(
          message:
              message ?? "Please enter a greater or equal value to $minValue.",
        );

  /// The minimum value of the value.
  final double minValue;

  @override
  bool isValid(String? value) =>
      value != null &&
      double.tryParse(value) != null &&
      double.parse(value) >= minValue;
}

/// {@template max_value_validator}
/// This validator check if the value is less than or equal to [maxValue].
/// {@endtemplate}
class MaximumValueValidator extends Validator<String?> {
  /// {@macro max_value_validator}
  const MaximumValueValidator({
    required this.maxValue,
    String? message,
  }) : super(
          message:
              message ?? "Please enter a lesser or equal value to $maxValue.",
        );

  /// The minimum value of the value.
  final double maxValue;

  @override
  bool isValid(String? value) =>
      value != null &&
      double.tryParse(value) != null &&
      double.parse(value) <= maxValue;
}

/// {@template min_length_validator}
/// This validator check if the value has a minimum length of [minLength].
/// {@endtemplate}
class MinimumLengthValidator extends Validator<String?> {
  /// {@macro min_length_validator}
  const MinimumLengthValidator({
    required this.minLength,
    String? message,
  }) : super(
          message: message ?? "Please enter at least $minLength characters.",
        );

  /// The minimum length of the value.
  final int minLength;

  @override
  bool isValid(String? value) => value != null && value.length < minLength;
}

/// {@template max_length_validator}
/// This validator check if the value has a maximum length of [maxLength].
/// {@endtemplate}
class MaximumLengthValidator extends Validator<String?> {
  /// {@macro max_length_validator}
  const MaximumLengthValidator({
    required this.maxLength,
    String? message,
  }) : super(
          message: message ?? "Please enter at most $maxLength characters.",
        );

  /// The maximum length of the value.
  final int maxLength;

  @override
  bool isValid(String? value) => value != null && value.length <= maxLength;
}

/// {@template form_validator}
/// A form field validator that checks for multiple validation on the value.
/// {@endtemplate}
class FormValidator {
  /// {@macro form_validator}
  const FormValidator(this.validators);

  /// A list of [Validator]s.
  final List<Validator<dynamic>> validators;

  /// Validates the value by iterating through the [validators].
  String? call(String? value) {
    for (var validator in validators) {
      if (!validator.isValid(value)) {
        return validator.message;
      }
    }
    return null;
  }
}
