abstract class HttpBase<T>{

  Future<void> onPreConnection(Future x);

  void onPostConnection(Future x);

  void onConnectionSucceed(Future x);

  void onConnectionFailed(Future x);

  void onMessageReceived(Future x);

  void onRetry(Future x);

}