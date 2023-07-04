import 'dart:math';

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

replyMessage(TeleDart teledart) {
  teledart.onMessage().listen((message) {
    print(message.from?.id);
  });
  teledart.onMessage(keyword: "Salom").listen((message) {
    teledart.sendMessage(message.chat.id, message.text.toString(),
        replyToMessageId: message.replyToMessage?.messageId);
    message.reply(
        'Assalomaleykum xabaringizni yozib qoldiring tez orada javob beraman',
        withQuote: true);
  });
}
