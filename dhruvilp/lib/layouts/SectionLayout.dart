import 'package:flutter/material.dart';

import '../theme_handler.dart';

class SectionLayout extends StatefulWidget {

  const SectionLayout({Key key, this.headlineText, this.child}) : super(key: key);

  final String headlineText;
  final Widget child;

  @override
  _SectionLayoutState createState() => _SectionLayoutState();
}

class _SectionLayoutState extends State<SectionLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          isWeb(context) ? Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 25.0, bottom: 25.0,),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    widget.headlineText,
                    softWrap: false,
                    style: Theme.of(context).textTheme.display4,
                  ),
                ),
              ),
            ),
          ) : Container(),
          Expanded(
            flex: 5,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}