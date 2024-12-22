import 'dart:io';

import 'package:hexagonal_bot_test/domain.dart';
import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:path/path.dart';

final class PostCommands with Application implements CommandDefinition {
  PlaceholderRepositoryContract get _repository => ioc.resolve<PlaceholderRepositoryContract>();

  File get config => File(join(app.configDir!.path, 'commands', 'post.yaml'));

  Future<void> fetchAll(CommandContext ctx) async {
    final posts = await _repository.getPosts();

    final embed = MessageEmbedBuilder()
      ..setTimestamp()
      ..setColor(Color.blue_400)
      ..setTitle('Posts list');

    for (final post in posts.take(10)) {
      embed.addField(name: post.title, value: post.content);
    }

    await ctx.interaction.reply(embeds: [embed.build()]);
  }

  Future<void> store(CommandContext ctx) async {
    final dialog = DialogBuilder('store_post_form')
      ..setTitle('New post')
      ..text(
          customId: 'title',
          title: 'Title',
          constraint: DialogFieldConstraint(minLength: 1, maxLength: 255, required: true))
      ..paragraph(
          customId: 'content',
          title: 'Content',
          constraint: DialogFieldConstraint(minLength: 1, maxLength: 255, required: true));

    await ctx.interaction.dialog(dialog);
  }

  Future<void> update(CommandContext ctx, {required int id}) async {
    final post = await _repository.getPost(id);
    if (post == null) {
      return;
    }

    final dialog = DialogBuilder('update_post_form:$id')
      ..setTitle('Update post')
      ..text(
          customId: 'title',
          title: 'Title',
          defaultValue: post.title,
          constraint: DialogFieldConstraint(minLength: 1, maxLength: 255, required: true))
      ..paragraph(
          customId: 'content',
          title: 'Content',
          defaultValue: post.content,
          constraint: DialogFieldConstraint(minLength: 1, maxLength: 255, required: true));

    await ctx.interaction.dialog(dialog);
  }

  Future<void> delete(CommandContext ctx, {required int id}) async {
    await _repository.deletePost(id);

    final embed = MessageEmbedBuilder()
      ..setTimestamp()
      ..setColor(Color.blue_400)
      ..setTitle('Posts deleted');

    await ctx.interaction.reply(embeds: [embed.build()]);
  }

  @override
  CommandDefinitionBuilder build() {
    return CommandDefinitionBuilder()
      ..using(config)
      ..setHandler('role.fetch', fetchAll)
      ..setHandler('role.store', store)
      ..context(
          'role.update',
          (SubCommandBuilder command) => command
            ..addOption(Option.integer(name: 'id', description: 'Post ID', required: true))
            ..setHandle(update))
      ..context(
          'role.delete',
          (SubCommandBuilder command) => command
            ..addOption(Option.integer(name: 'id', description: 'Post ID', required: true))
            ..setHandle(delete));
  }
}
