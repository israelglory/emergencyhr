/// One button under a bot message: it either sends [callbackData] back to
/// the server or opens [url].
class BotButton {
  const BotButton.callback(this.text, String data)
    : callbackData = data,
      url = null;
  const BotButton.url(this.text, String link) : url = link, callbackData = null;

  final String text;
  final String? callbackData;
  final String? url;

  Map<String, Object> toJson() => {
    'text': text,
    'callback_data': ?callbackData,
    'url': ?url,
  };
}

/// A button on the keyboard that replaces the phone keyboard. With
/// [requestLocation], tapping it shares the person's location.
class KeyboardButton {
  const KeyboardButton(this.text, {this.requestLocation = false});

  final String text;
  final bool requestLocation;

  Map<String, Object> toJson() => {
    'text': text,
    if (requestLocation) 'request_location': true,
  };
}

/// A bot reply, independent of the Telegram API so it can be tested. [text]
/// is Telegram HTML: escape anything that comes from the database with
/// [BotMessage.escape].
class BotMessage {
  const BotMessage(this.text, {this.buttons = const [], this.keyboard});

  final String text;

  /// Rows of buttons under the message.
  final List<List<BotButton>> buttons;

  /// Rows of keyboard buttons. Only used when sending a new message.
  final List<List<KeyboardButton>>? keyboard;

  static String escape(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');

  Map<String, Object> toJson() => {
    'text': text,
    'parse_mode': 'HTML',
    'link_preview_options': {'is_disabled': true},
    if (buttons.isNotEmpty)
      'reply_markup': {
        'inline_keyboard': [
          for (final row in buttons) [for (final b in row) b.toJson()],
        ],
      }
    else if (keyboard != null)
      'reply_markup': {
        'keyboard': [
          for (final row in keyboard!) [for (final b in row) b.toJson()],
        ],
        'resize_keyboard': true,
        'is_persistent': true,
      },
  };
}
