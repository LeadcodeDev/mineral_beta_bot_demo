import 'package:hexagonal_bot_test/domain.dart';
import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';

final class PlaceholderCreatePostEvent extends ServerDialogSubmitEvent {
  PlaceholderRepositoryContract get _repository => ioc.resolve<PlaceholderRepositoryContract>();

  @override
  String get customId => 'store_post_form';

  @override
  Future<void> handle(ServerDialogContext ctx, data) async {
    final String title = data['title'];
    final String content = data['content'];

    final id = await _repository.createPost(title, content);
    final message = switch(id) {
      int value => 'Post $value was created',
      _ => 'Unexpected error'
    };

    await ctx.interaction.reply(content: message, ephemeral: true);
  }
}
