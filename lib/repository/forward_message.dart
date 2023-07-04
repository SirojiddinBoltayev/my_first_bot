import 'package:first_tg_bot/service/get_exchange.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:teledart/teledart.dart';

forwardMessage(TeleDart teledart) {
  var parser = EmojiParser();
  dynamic data = "";

  teledart.onMessage().listen((message) async {
    var currencyRate = await getCurrencyRate();
    List list = [];

    bool isForward = false;
    for (var rate in currencyRate!) {
      list.add(rate.title == message.text);
    }
    for (var isTrue in list) {
      if (isTrue) {
        isForward = false;
        break;
      }
      isForward = true;
    }
    if (message.text == parser.emojify(":heavy_dollar_sign: Valyuta kursi")) {
      isForward = false;
    }
    if (message.text == parser.emojify(":back: Ortga qaytish")) {
      isForward = false;
    }

    if (isForward) {
      if (1224293108 != message.chat.id)
        teledart.forwardMessage(1224293108, message.chat.id, message.messageId);
      isForward = false;
    }
  });
}
