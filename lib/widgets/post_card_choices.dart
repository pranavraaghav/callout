import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCardChoice {
  String choiceName;
  Icon choiceIcon;

  PostCardChoice({String choiceName, Icon choiceIcon});
}

List<PostCardChoice> postCardChoices = [
  PostCardChoice(choiceName: 'Report', choiceIcon: Icon(Icons.flag_outlined)),
  PostCardChoice(choiceName: 'Details', choiceIcon: Icon(Icons.subject)),
];
