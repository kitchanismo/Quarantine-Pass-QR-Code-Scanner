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
    final validity = DateTime(date.year, date.month, date.day);
    final now = DateTime.now();
    final current = DateTime(now.year, now.month, now.day);

    if (validity.compareTo(current) < 0) {
      return false;
    }
    return true;
  }
}
