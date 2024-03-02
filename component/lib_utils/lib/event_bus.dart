import 'package:event_bus/event_bus.dart';

class Bus {
  Bus._();

  static Bus? _bus;
  static late EventBus _eventBus;

  static Bus getInstance() {
    if (_bus == null) {
      _bus = Bus._();
      _eventBus = EventBus();
    }
    return _bus!;
  }

  void send(event) {
    _eventBus.fire(event);
  }

  Stream<T> register<T>() {
    return _eventBus.on<T>();
  }
}
