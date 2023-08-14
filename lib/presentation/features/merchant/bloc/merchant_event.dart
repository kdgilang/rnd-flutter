abstract class MerchantEvent {
  const MerchantEvent();

  List<Object?> get props => [];
}

class FetchData extends MerchantEvent {
  const FetchData({ required this.id });

  final String id;

  @override
  List<Object?> get props => [id];
}