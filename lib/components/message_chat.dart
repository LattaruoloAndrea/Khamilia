import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:intl/intl.dart';

class MessageChat extends StatelessWidget {
  final MessageClass message;

  const MessageChat({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: message.sender! ? Colors.pink[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(8),
        margin: message.sender!
            ? EdgeInsets.only(left: 65, right: 5, top: 5, bottom: 1)
            : EdgeInsets.only(left: 5, right: 65, top: 5, bottom: 2),
        child: Column(
            children: [correct_widget(message), timeWidget(message.timestamp!,message.sender)])
        // Column(children: [
        //   message.sender!? Expanded(child: correct_widget(message),) : timeWidget(message.timestamp!),
        //   message.sender!? timeWidget(message.timestamp!) :  Expanded(child: correct_widget(message),),
        // ],),
        );
  }

  Widget correct_widget(MessageClass message) {
    if (message.isCorrect()) {
      switch (message.type) {
        case 'mic':
          return _MicMessage(message);
        case 'text':
          return _TextMessage(message);
        case 'activities':
          return _ActivitiesMessage(message);
        case 'group':
          return _GroupMessage(message);
        case 'query':
          return _QueryMessage(message);
        case 'set-time':
          return _TimeMessage(message);
        case 'set-periodicy':
          return _PeriodicyMessage(message);
        case 'support':
          return _SupportMessage(message);
        case 'loading':
          return _LoadingMessage(message);
        default:
          return _ErrorMessage(message);
      }
    } else {
      return _ErrorMessage(message);
    }
  }

  Widget timeWidget(DateTime timestamp,sender) {
    var alignment =(sender!) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      // alignment: alignment,
      child: Text(
        DateFormat.Hm().format(timestamp),
        style: TextStyle(fontSize: 11),
      ),
    );
  }

  Widget _MicMessage(MessageClass message) {
    return Text(
      'Text',
      style: TextStyle(backgroundColor: Colors.yellow),
    );
  }

  Widget _TextMessage(MessageClass message) {
    return Text(
      message.input!,
    );
  }

  Widget _ActivitiesMessage(MessageClass message) {
    return Text('Activities', style: TextStyle(backgroundColor: Colors.yellow));
  }

  Widget _GroupMessage(MessageClass message) {
    return Text('Group', style: TextStyle(backgroundColor: Colors.blue));
  }

  Widget _QueryMessage(MessageClass message) {
    return Text('Query', style: TextStyle(backgroundColor: Colors.pink));
  }

  Widget _TimeMessage(MessageClass message) {
    return Text('Time', style: TextStyle(backgroundColor: Colors.purple));
  }

  Widget _PeriodicyMessage(MessageClass message) {
    return Text('Periodicty', style: TextStyle(backgroundColor: Colors.green));
  }

  Widget _SupportMessage(MessageClass message) {
    return Text('Support', style: TextStyle(backgroundColor: Colors.grey));
  }

  Widget _LoadingMessage(MessageClass message) {
    return Text('Error',
        style: TextStyle(
            backgroundColor: const Color.fromARGB(255, 54, 238, 244)));
  }

  Widget _ErrorMessage(MessageClass message) {
    return Text('Error', style: TextStyle(backgroundColor: Colors.red));
  }
}
