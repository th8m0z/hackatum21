import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    Key key,
    this.instructionStep,
  }) : super(key: key);
  final InstructionStep instructionStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sc.h * 2.5,
            spreadRadius: Sc.h * 0.1,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      height: Sc.v * 60,
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: Sc.h * 5.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            child: Center(
              child: Text(
                instructionStep.number.toString(),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ),
          SizedBox(
            width: Sc.h * 4,
          ),
          Flexible(
            child: Container(
              child: AutoSizeText(
                instructionStep.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
