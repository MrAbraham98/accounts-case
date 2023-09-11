enum MimeType {
  svg,
  png,
  jpeg,
  gif,
  pdf,
  other;

  bool get isCompressable => this == MimeType.png || this == MimeType.jpeg;
}
