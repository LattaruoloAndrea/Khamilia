import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';

class MessageChat extends StatelessWidget {
  final MessageClass message;

  const MessageChat({super.key, required this.message});


  @override
  Widget build(BuildContext context) {
    switch (message.type) {
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
  }

  Widget _TextMessage(message) {
    return Text(
      'Text',
      style: TextStyle(backgroundColor: Colors.yellow),
    );
  }

  Widget _ActivitiesMessage(message) {
    return Text('Activities', style: TextStyle(backgroundColor: Colors.yellow));
  }

  Widget _GroupMessage(message) {
    return Text('Group', style: TextStyle(backgroundColor: Colors.blue));
  }

  Widget _QueryMessage(message) {
    return Text('Query', style: TextStyle(backgroundColor: Colors.pink));
  }

  Widget _TimeMessage(message) {
    return Text('Time', style: TextStyle(backgroundColor: Colors.purple));
  }

  Widget _PeriodicyMessage(message) {
    return Text('Periodicty', style: TextStyle(backgroundColor: Colors.green));
  }

  Widget _SupportMessage(message) {
    return Text('Support', style: TextStyle(backgroundColor: Colors.grey));
  }

  Widget _LoadingMessage(message) {
    return Text('Error',
        style: TextStyle(
            backgroundColor: const Color.fromARGB(255, 54, 238, 244)));
  }

  Widget _ErrorMessage(message) {
    return Text('Error', style: TextStyle(backgroundColor: Colors.red));
  }
}
