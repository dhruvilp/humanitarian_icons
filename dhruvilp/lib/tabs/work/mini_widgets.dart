import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../theme_handler.dart';

///---------------------------------------
///            WORK EXPERIENCE
///---------------------------------------

class ExperienceWidget extends StatefulWidget {

  const ExperienceWidget({Key key, this.companyLogo, this.title, this.company, this.date, this.description, this.techStack, this.webUrl}) : super(key: key);

  final Image companyLogo;
  final String title;
  final String company;
  final String date;
  final String description;
  final List<String> techStack;
  final String webUrl;

  @override
  _ExperienceWidgetState createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget>{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: widget.companyLogo,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0,),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: '${widget.title}\n', style: isWeb(context) ? Theme.of(context).textTheme.display1 : TextStyle(fontSize: 25.0, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w200, fontFamily: 'Quicksand',),),
                                TextSpan(text: '${widget.company}\n', style: isWeb(context) ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.subhead,),
                                TextSpan(text: '${widget.date}\n', style: isWeb(context) ? Theme.of(context).textTheme.subhead : Theme.of(context).textTheme.body1,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runSpacing: 0.0,  // vertical
                          spacing: 8.0, //
                          alignment: WrapAlignment.start,// horizontal
                          direction: Axis.horizontal,
                          children: widget.techStack.map((String name) => Chip(
                            padding: EdgeInsets.all(8.0),
                            backgroundColor: Theme.of(context).hoverColor,
                            elevation: 2.0,
                            shadowColor: Theme.of(context).hoverColor,
                            labelStyle: Theme.of(context).textTheme.body2,
                            label: Text(name, style: TextStyle(color: white),),
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: isWeb(context) ? const EdgeInsets.only(right: 45.0, left: 45.0, top: 45.0,) : EdgeInsets.only(top: 16.0,),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: '${widget.description}\n', style: Theme.of(context).textTheme.title,),
                ],
              ),
            ),
          ),
          Padding(
            padding: isWeb(context) ? const EdgeInsets.only(right: 45.0, left: 30.0, bottom: 45.0,) : EdgeInsets.all(0.0,),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: (){
                  launchURL(widget.webUrl);
                },
                label: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0,),
                  child: Text('Learn More', style: Theme.of(context).textTheme.subhead,),
                ),
                icon: Icon(Icons.web, color: Theme.of(context).primaryColor,),
                color: Theme.of(context).scaffoldBackgroundColor,
                splashColor: Theme.of(context).scaffoldBackgroundColor,
                hoverColor: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
