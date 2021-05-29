abstract class StringValidator {
  bool isValid(String v);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
}