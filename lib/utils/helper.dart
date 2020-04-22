class Helper {
  static String toElipse({String input, int end = 17}) {
    if (input.length > end) {
      String str = input.substring(0, end);
      return '$str ...';
    }

    return input;
  }

  static String dateOnly(DateTime date) {
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static bool isPassValid(DateTime date) {
    if (date.compareTo(DateTime.now()) < 0) {
      return false;
    }
    return true;
  }
}
