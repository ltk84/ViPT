import 'package:flutter/material.dart';

class ChoiceCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? asset;
  final bool isMultipleSelectionMode;
  final bool isSelected;

  const ChoiceCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.asset,
    this.isMultipleSelectionMode = true,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<ChoiceCard> createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: _isSelected
            ? BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.2,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: ListTile(
          leading: widget.asset == null
              ? null
              : Image.asset(
                  widget.asset as String,
                ),
          title:
              Text(widget.title, style: Theme.of(context).textTheme.headline4),
          subtitle: widget.subtitle == null
              ? null
              : Text(widget.subtitle as String,
                  style: Theme.of(context).textTheme.subtitle1),
          trailing: widget.isMultipleSelectionMode
              ? _isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked_outlined,
                    )
              : null,
        ),
      ),
    );
  }
}
