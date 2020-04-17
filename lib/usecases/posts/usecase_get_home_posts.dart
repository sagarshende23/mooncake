import 'package:meta/meta.dart';
import 'package:mooncake/entities/entities.dart';
import 'package:mooncake/usecases/posts/posts.dart';

/// Allows to read all the posts that should be seen inside the main page.
class GetHomePostsUseCase {
  final PostsRepository _postsRepository;

  GetHomePostsUseCase({@required PostsRepository postsRepository})
      : assert(postsRepository != null),
        _postsRepository = postsRepository;

  /// Returns the posts that should be seen inside the main screen.
  Stream<List<Post>> stream(int limit) {
    return _postsRepository.getHomePostsStream(limit);
  }

  /// Refreshes the home posts by downloading them from the remote
  /// repository.
  Future<List<Post>> refresh({int start, int limit}) {
    return _postsRepository.refreshHomePosts(start: start, limit: limit);
  }
}
