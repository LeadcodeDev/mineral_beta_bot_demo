import 'package:hexagonal_bot_test/domain.dart';
import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/events.dart';

final class PlaceholderEditPostEvent extends ServerDialogSubmitEvent {
  PlaceholderRepositoryContract get _repository => ioc.resolve<PlaceholderRepositoryContract>();

  @override
  Future<void> handle(ServerDialogContext ctx, data) async {
    print(ctx.customId);
    if (!ctx.customId.startsWith('update_post_form')) {
      return;
    }

    final id = int.parse(ctx.customId.replaceFirst('update_post_form:', ''));

    final String title = data['title'];
    final String content = data['content'];

    try {
      await _repository.updatePost(id, title, content);
      await ctx.interaction.reply(content: 'Post $id was update', ephemeral: true);
    } catch (error) {
      await ctx.interaction.reply(content: error.toString(), ephemeral: true);
    }
  }
}
