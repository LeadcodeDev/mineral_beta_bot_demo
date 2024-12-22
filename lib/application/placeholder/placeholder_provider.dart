import 'package:hexagonal_bot_test/application.dart';
import 'package:mineral/api.dart';

final class PlaceholderProvider extends Provider {
  final Client _client;

  PlaceholderProvider(this._client) {
    _client.register(PostCommands.new);
    _client.register(PlaceholderCreatePostEvent.new);
    _client.register(PlaceholderEditPostEvent.new);
  }
}
