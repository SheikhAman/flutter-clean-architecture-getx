class PostEntity {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
