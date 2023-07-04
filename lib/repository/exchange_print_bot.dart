import 'package:first_tg_bot/core/stream_data.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import '../service/get_exchange.dart';

exchange_rate_print(TeleDart teledart) {
  var data = StreamButton();
  List listFlags = [];
  var parser = EmojiParser();
  bool showMenu = false;
  teledart.onMessage().listen((message) async {
    if (message.text != null) {
      var currencyRate = await getCurrencyRate();

      if (currencyRate != null) {
        for (var rate in currencyRate) {
          if (message.text == rate.title) {
            teledart.sendMessage(message.chat.id,
                "O'zbekiston Milliy Banki tomondan e'lon qilingan ${rate.title}ning bugungi kurs narxi\n\n\n\n 1   ${rate.code}         ${rate.cb_price} so'm");
          }
        }
      }
    }
  });

  teledart.onMessage().listen((message) async {
    if (message.text == parser.emojify(":heavy_dollar_sign: Valyuta kursi")) {
      var currencyRate = await getCurrencyRate();

      var keyboard = List.generate(
          currencyRate?.length ?? 0,
          (index) => [
                if (0 == index)
                  KeyboardButton(text: parser.emojify(":back: Ortga qaytish")),
                KeyboardButton(
                    text:
                        parser.emojify(currencyRate![index].title.toString())),
              ]);
      var markup = ReplyKeyboardMarkup(
        keyboard: keyboard,
        resizeKeyboard: true,
        oneTimeKeyboard: false,
        selective: false,
      );

      teledart.sendMessage(
        message.chat.id,
        parser.emojify("Kerakli bo'limni tanlang :point_down:"),
        replyMarkup: markup,
      );
    }
  });
}
