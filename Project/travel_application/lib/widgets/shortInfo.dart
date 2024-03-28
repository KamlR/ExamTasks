import 'package:flutter/material.dart';

class NewsDetailsShort extends StatelessWidget {
  final String labelText;
  final String valueText;

  const NewsDetailsShort({
    Key? key, 
    required this.labelText,
    required this.valueText, TextStyle? style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$labelText: ',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Expanded( // Заменено на Expanded
            child: valueText.contains("https")
                ? GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(valueText);
                    },
                    child: Text(
                      valueText,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  )
                : Text(
                    valueText,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
          ),
        ],
      ),
    );
  }
}
