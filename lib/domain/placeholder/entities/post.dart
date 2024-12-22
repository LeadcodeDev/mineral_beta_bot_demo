final class Post {
  final int id;
  final int userId;
  final String title;
  final String content;

  Post({required this.id, required this.userId, required this.title, required this.content});

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      id: data['id'],
      userId: data['userId'],
      title: data['title'],
      content: data['body'],
    );
  }
}
