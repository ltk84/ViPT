class Answer {
  final String title;
  final String? description;
  final dynamic asset;
  bool isSelected;
  final dynamic enumValue;

  Answer(
      {required this.title,
      this.description = '',
      this.asset,
      this.isSelected = false,
      this.enumValue});
}
