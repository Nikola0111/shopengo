/// T should be enum
/// In dart we cannot constrain generic to only enum
mixin SubscriptionMixin<T> {
  final List<Function> _subscriptions = [];

  void subscribe(Function(T, List<dynamic>) listener) => _subscriptions.add(listener);
  void unsubscribe(Function listener) => _subscriptions.remove(listener);

  /// Sends event to listeners
  void sendEvent(T event, {List<dynamic> params = const [], Function? exclude}) {
    for (Function listener in _subscriptions) {
      if (listener == exclude) continue;
      listener(event, params);
    }
  }
}
