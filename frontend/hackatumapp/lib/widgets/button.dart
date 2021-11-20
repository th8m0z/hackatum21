import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';

class Button extends StatefulWidget {
  final Widget child;
  final Color color;
  final double height;
  final double width;
  final Function onTap;
  final bool hasBoxshadow;
  final double borderRadius;
  final bool gestureOnly;
  final LinearGradient gradient;
  final bool opacityOnly;
  final bool isCentered;

  const Button(
      {Key key,
      this.gradient,
      this.child,
      this.color,
      this.height,
      this.width,
      this.onTap,
      this.opacityOnly,
      this.hasBoxshadow,
      this.gestureOnly,
      this.borderRadius,
      this.isCentered})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  CustomAnimationControl control = CustomAnimationControl.STOP;
  CustomAnimationControl opacityControl = CustomAnimationControl.STOP;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            opacityControl = CustomAnimationControl.PLAY_REVERSE;
            control = CustomAnimationControl.PLAY_REVERSE;
          });
          if (widget.onTap != null) {
            HapticFeedback.lightImpact();
            widget.onTap();
          }
        },
        onTapDown: (details) {
          setState(() {
            opacityControl = CustomAnimationControl.PLAY;

            control = CustomAnimationControl.PLAY;
          });
        },
        onTapCancel: () {
          setState(() {
            opacityControl = CustomAnimationControl.PLAY_REVERSE;
            control = CustomAnimationControl.PLAY_REVERSE;
          });
        },
        child: CustomAnimation(
          duration: Duration(milliseconds: 200),
          control: control,
          tween: Tween(begin: 1.0, end: 0.9),
          builder: (context, optionalChild, value) {
            return CustomAnimation(
              control: opacityControl,
              duration: Duration(milliseconds: 200),
              tween: Tween<double>(begin: 1.0, end: 0.7),
              builder: (context, optionalChild, double animation) =>
                  Transform.scale(
                scale: widget.opacityOnly == true ? 1.0 : value,
                child: Opacity(
                  opacity: animation,
                  child: widget.gestureOnly == true
                      ? widget.child
                      : Container(
                          child: widget.isCentered == false
                              ? widget.child
                              : Center(child: widget.child),
                          height: widget.height,
                          width: widget.width,
                          decoration: BoxDecoration(
                              gradient: widget.gradient,
                              boxShadow: widget.hasBoxshadow == true
                                  ? [
                                      BoxShadow(
                                        color: widget.color != null
                                            ? widget.color.withOpacity(0.5)
                                            : Colors.black.withOpacity(0.6),
                                        blurRadius: 12.0,
                                        spreadRadius: 0,
                                      )
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 20),
                              color: widget.color ??
                                  Theme.of(context).accentColor),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
