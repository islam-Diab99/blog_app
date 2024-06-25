class ApiConstance {
  static const String baseUrl =
      "https://66797c1e18a459f639500f34.mockapi.io/api/v1/";
  static const String getAllPostsPath = "$baseUrl/post";
  static String updatePostPath(postId) => "$baseUrl/post/$postId";
  static const String createPostPath = "$baseUrl/post";
}
