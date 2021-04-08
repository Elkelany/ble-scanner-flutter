enum InitialPageState { initial }

enum InitialPageEvent { scan }

class InitialPageMessage {
  final InitialPageState state;
  final InitialPageEvent event;

  InitialPageMessage({
    InitialPageState state,
    InitialPageEvent event,
  })  : this.state = state,
        this.event = event;

  factory InitialPageMessage.defaultValue() {
    return InitialPageMessage(
      state: InitialPageState.initial,
    );
  }

  InitialPageMessage copyWith({
    InitialPageState state,
    InitialPageEvent event,
  }) {
    return InitialPageMessage(
      state: state ?? this.state,
      event: event ?? this.event,
    );
  }

  @override
  String toString() {
    return '''InitialPageMessage(
     state: $state,
     event: $event,
     )''';
  }
}
