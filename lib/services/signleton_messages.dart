import 'package:gemini_app/components/message_class.dart';

class SignletonMessages {
  static final instance = SignletonMessages();
   List<MessageClass> messages = [];
  
  add(MessageClass message){
    messages.add(message);
  }

  List<MessageClass> get(){
    return messages;
  }

}