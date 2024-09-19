
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'default/dash.png',
            scale: 3,
          ),
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
