extension StringExtension on String {
  bool isEqual(String string) => toLowerCase().contains(string.toLowerCase());
}
