import 'package:flutter/material.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/button.dart';

class QuizButton extends StatefulWidget {
  final String content;
  final Function(String) onSelect;
  final Function(String) onDeselect;
  final String caption;
  final String defaultAsset;
  final String selectedAsset;
  final Color color;
  const QuizButton(
      {Key key,
      this.onDeselect,
      this.defaultAsset,
      this.selectedAsset,
      this.caption,
      this.onSelect,
      this.color,
      this.content})
      : super(key: key);

  @override
  _QuizButtonState createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Button(
      opacityOnly: true,
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (isSelected) {
          if (widget.onSelect != null) {
            widget.onSelect(widget.content);
          }
        } else {
          if (widget.onDeselect != null) {
            widget.onDeselect(widget.content);
          }
        }
      },
      gestureOnly: true,
      child: Container(
        height: Sc.v * 32,
        width: Sc.h * 32,
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  color: Colors.green[900],
                  width: Sc.h * 1,
                )
              : Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: Sc.h * 1,
                ),
          borderRadius: BorderRadius.circular(10),
          color: widget.color ?? Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.defaultAsset == null
                ? SizedBox.shrink()
                : Image.asset(widget.defaultAsset, height: Sc.v * 25),
            Text(
              widget.caption ?? "Get more done",
              style: Theme.of(context).textTheme.caption,

              // kBodyStyle.copyWith(
              //     color: Theme.of(context).primaryColor,
              //     fontWeight: FontWeight.w800,
              //     fontSize: Sc.h * 4),
            )
          ],
        ),
      ),
    );
  }
}
