import 'package:flutter/material.dart';

/// Represents a single mnemonic word item that is shown inside the
/// list of words of a new mnemonic.
class MnemonicItem extends StatelessWidget {
  final int index;
  final String word;

  const MnemonicItem({
    Key key,
    @required this.index,
    @required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('$index.'),
          SizedBox(width: 4),
          Text(word),
        ],
      ),
    );
  }
}
