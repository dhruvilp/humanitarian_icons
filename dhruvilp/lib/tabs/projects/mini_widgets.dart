import 'package:dhruvilp/constants.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../theme_handler.dart';

///---------------------------------------
///            WORK EXPERIENCE
///---------------------------------------

class ProjectCard extends StatefulWidget {

  const ProjectCard({Key key, this.demoImage, this.title, this.briefDescription, this.achievement, this.description, this.techStack, this.projectLink}) : super(key: key);

  final Image demoImage;
  final String title;
  final String briefDescription;
  final String achievement;
  final String description;
  final List<String> techStack;
  final String projectLink;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>{

  Widget demoImageWidget(){
    return Container(
      child: Center(
        child: widget.demoImage,
      ),
    );
  }

  Widget descriptionWidget(){
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
                    TextSpan(text: '${widget.title}', style: isWeb(context) ? Theme.of(context).textTheme.display1 : TextStyle(color: Theme.of(context).primaryColor, fontSize: 25.0, fontFamily: 'Quicksand',),),
                    TextSpan(text: '${widget.briefDescription}\n', style: isWeb(context) ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.subhead,),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              runSpacing: 0.0,
              spacing: 8.0,
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
          SizedBox(height: 20.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    widget.achievement != null ? TextSpan(text: '${widget.achievement}\n', style: Theme.of(context).textTheme.title,) : TextSpan(),
                    TextSpan(text: '${widget.description}\n', style: Theme.of(context).textTheme.subhead,),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Align(
            alignment: isWeb(context) ? Alignment.centerLeft : Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: (){
                launchURL(ITRIAGE_URL);
              },
              label: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0,),
                child: Text('Source Code', style: Theme.of(context).textTheme.subhead,),
              ),
              icon: Icon(Icons.code, color: Theme.of(context).primaryColor,),
              color: Theme.of(context).scaffoldBackgroundColor,
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              hoverColor: Theme.of(context).primaryColorLight,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isWeb(context) ? const EdgeInsets.only(right: 60.0,) : EdgeInsets.all(0.0,),
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: isWeb(context) ? EdgeInsets.all(40.0) : EdgeInsets.only(right: 18.0, left: 18.0, top: 25.0,),
        child: isWeb(context) ? Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: demoImageWidget(),
            ),
            Expanded(
              flex: 3,
              child: descriptionWidget(),
            ),
          ],
        ) : Column(
          children: <Widget>[
            demoImageWidget(),
            descriptionWidget(),
          ],
        ),
      ),
    );
  }
}