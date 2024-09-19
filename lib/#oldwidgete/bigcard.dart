
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.mots,
  });

  final WordPair mots;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color:  const Color.fromARGB(255, 58, 4, 105),
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("${mots.first} ${mots.second}", style: style,semanticsLabel: "${mots.first} ${mots.second}",),
      ),
    );
  }
}