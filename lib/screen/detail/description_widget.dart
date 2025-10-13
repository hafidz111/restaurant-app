import 'package:flutter/material.dart';

class ExpandableDescription extends StatelessWidget {
  final String text;
  final ValueNotifier<bool> expanded = ValueNotifier(false);

  ExpandableDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final didExceed = tp.didExceedMaxLines;
        final endIndex = didExceed
            ? tp
                  .getPositionForOffset(Offset(constraints.maxWidth, tp.height))
                  .offset
            : text.length;
        final visibleText = text.substring(0, endIndex);

        return ValueListenableBuilder<bool>(
          valueListenable: expanded,
          builder: (context, value, _) {
            final showFull = value || !didExceed;

            return RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: style,
                children: [
                  TextSpan(
                    text: showFull ? "$text " : "${visibleText.trimRight()}… ",
                  ),
                  if (didExceed)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () => expanded.value = !value,
                        child: Text(
                          value ? "Read less" : "Read more",
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
          },
        );
      },
    );
  }
}
