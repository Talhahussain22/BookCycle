import 'package:form_field_validator/form_field_validator.dart';

final userNameValidator = RequiredValidator(errorText: 'User name is required');
final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 characters long'),
  PatternValidator(r'(?=.*?[A-Z])', errorText: 'Password must have at least one uppercase letter'),
  PatternValidator(r'(?=.*?[0-9])', errorText: 'Password must have at least one number'),
  PatternValidator(r'(?=.*?[!@#\$&*~])', errorText: 'Password must have at least one special character'),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone# is required'),
  MinLengthValidator(13, errorText: 'Phone#  must be at least 13 digits long'),
]);
final fieldValidator = RequiredValidator(errorText: 'Field is required');