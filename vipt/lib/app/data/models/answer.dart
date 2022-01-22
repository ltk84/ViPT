class Answer {
  final String title;
  final String? description;
  final dynamic asset;
  bool isSelected;

  Answer(
      {required this.title,
      this.description = '',
      this.asset,
      this.isSelected = false});
}
