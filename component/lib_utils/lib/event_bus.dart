import 'package:event_bus/event_bus.dart';

class Bus {
  Bus._();

  static Bus _eventBusWarp;
  static EventBus _eventBus;

  static Bus getInstance() {
    if (_eventBusWarp == null) {
      _eventBusWarp = Bus._();
      _eventBus = EventBus();
    }
    return _eventBusWarp;
  }

  void send(event) {
    _eventBus.fire(event);
  }

  Stream<T> register<T>() {
    return _eventBus.on<T>();
  }
}
