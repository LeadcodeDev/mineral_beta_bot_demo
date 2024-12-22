import 'package:hexagonal_bot_test/domain.dart';

final class PlaceholderRepository implements PlaceholderRepositoryContract {
  final PlaceholderClientContract _http;

  PlaceholderRepository(this._http);

  @override
  Future<List<Post>> getPosts() async {
    final response = await _http.get('/posts');
    return List.from(response.body).map((post) => Post.fromJson(post)).toList();
  }

  @override
  Future<Post?> getPost(int id) async {
    final response = await _http.get('/posts/$id');
    return switch (response.statusCode) {
      int code when code == 200 => Post.fromJson(response.body),
      _ => null,
    };
  }

  @override
  Future<int> createPost(String title, String content) async {
    final response =
        await _http.post('/posts', body: {'userId': 1, 'title': title, 'body': content});

    return response.body['id'];
  }

  @override
  Future<int> updatePost(int id, String title, String content) async {
    final response =
    await _http.put('/posts/$id', body: {'userId': 1, 'title': title, 'body': content});

    return response.body['id'];
  }

  @override
  Future<void> deletePost(int id) async {
    await _http.delete('/posts/$id');
  }
}
