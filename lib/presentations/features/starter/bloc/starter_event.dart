abstract class StarterEvent {
  const StarterEvent();

  List<Object?> get props => [];
}

class OnMounted extends StarterEvent {
  const OnMounted({ required this.id });

  final String id;

  @override
  List<Object?> get props => [id];
}