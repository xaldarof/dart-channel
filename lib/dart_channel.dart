class DartChannel<T> {
  List<T?> values = [];
  int bufferSize;

  final List<OnValueChangeCallBack<T?>> _listeners = [];

  void emit(T? value) {
    values.add(value);
    if (values.length > bufferSize) {
      values.removeAt(0);
    }
    _invokeListeners();
  }

  void _invokeListeners() {
    for (var listener in _listeners) {
      for (var element in values) {
        listener.call(element);
      }
      if (values.length > bufferSize) {
        values.removeRange(values.length - bufferSize, values.length - 1);
      }
    }
  }

  T? getFirst() {
    return values[0];
  }

  T? getLast() {
    return values[values.length - 1];
  }

  void addListener(OnValueChangeCallBack<T?> value) {
    _listeners.add(value);
    _invokeListeners();
  }

  void removeListener(OnValueChangeCallBack<T?> value) {
    _listeners.remove(value);
  }

  void clearListeners() {
    _listeners.clear();
  }

  DartChannel({
    required this.bufferSize,
  }) {
    assert(bufferSize > 0);
  }
}

typedef OnValueChangeCallBack<T> = Function(T);
