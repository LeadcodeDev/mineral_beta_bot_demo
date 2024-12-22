import 'package:hexagonal_bot_test/domain/placeholder/entities/post.dart';
import 'package:mineral/services.dart';

abstract interface class PlaceholderClientContract implements HttpClientContract {}

abstract interface class PlaceholderRepositoryContract {
  Future<List<Post>> getPosts();

  Future<Post?> getPost(int id);

  Future<int?> createPost(String title, String content);

  Future<int> updatePost(int id, String title, String content);

  Future<void> deletePost(int id);
}
