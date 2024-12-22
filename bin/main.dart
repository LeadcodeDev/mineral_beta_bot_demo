import 'package:hexagonal_bot_test/application.dart';
import 'package:hexagonal_bot_test/domain.dart';
import 'package:hexagonal_bot_test/infrastructure.dart';
import 'package:mineral/api.dart';
import 'package:mineral_cache/providers/memory.dart';

void main(_, port) async {
  final client = ClientBuilder()
      .setCache((e) => MemoryProvider())
      .setHmrDevPort(port)
      .registerProvider(PlaceholderProvider.new)
      .build();

  final http = PlaceholderHttpClient();
  client.container.bind<PlaceholderRepositoryContract>(() => PlaceholderRepository(http));

  client.events.ready((bot) {
    client.logger.info('${bot.username} is ready ! 🚀');
  });

  await client.init();
}
