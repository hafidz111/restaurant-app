import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;
  const ExpandableDescription({super.key, required this.text});

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (!expanded) {
          final span = TextSpan(text: widget.text, style: style);
          final tp = TextPainter(
            text: span,
            maxLines: 3,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          String visibleText = widget.text;
          if (tp.didExceedMaxLines) {
            final endIndex = tp
                .getPositionForOffset(Offset(constraints.maxWidth, tp.height))
                .offset;
            visibleText = widget.text.substring(0, endIndex);
          }

          return RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: style,
              children: [
                TextSpan(text: "${visibleText.trimRight()}… "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () => setState(() => expanded = true),
                    child: Text(
                      "Read more",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: style,
              children: [
                TextSpan(text: "${widget.text} "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () => setState(() => expanded = false),
                    child: Text(
                      "Read less",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
