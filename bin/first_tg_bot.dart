import 'dart:convert';
import 'package:first_tg_bot/repository/exchange_print_bot.dart';
import 'package:first_tg_bot/repository/forward_message.dart';
import 'package:first_tg_bot/repository/reply_message.dart';
import 'package:first_tg_bot/service/get_exchange.dart';
import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import '../lib/model/exchange_model.dart';

Future<void> main() async {
  var botToken = '6330873616:AAE0SoKc93g0VCPrK1rd6UomogLvx31cI4c';
  final username = (await Telegram(botToken).getMe()).username;
  var teledart = TeleDart(botToken, Event(username!));
  var parser = EmojiParser();
  teledart.start();
  teledart.onMessage().listen((message) {});
  menu(teledart, parser);
  exchange_rate_print(teledart);
}

menu(TeleDart teledart, EmojiParser parser) async {
  var currencyRate = await getCurrencyRate();

  teledart.onCommand('start').listen((message) async {
    var keyboard = [
      [
        KeyboardButton(
            text: parser.emojify(":heavy_dollar_sign: Valyuta kursi")),
        KeyboardButton(
            text: parser.emojify(":bust_in_silhouette: Shaxsiyga yozish")),
      ]
    ];
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
  });

  teledart.onMessage().listen((message) {
    if (message.text == parser.emojify(":back: Ortga qaytish")) {
      var keyboard = [
        [
          KeyboardButton(
              text: parser.emojify(":heavy_dollar_sign: Valyuta kursi")),
          KeyboardButton(
              text: parser.emojify(":bust_in_silhouette: Shaxsiyga yozish")),
        ]
      ];
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
  replyMessage(teledart);
  forwardMessage(teledart);
}
