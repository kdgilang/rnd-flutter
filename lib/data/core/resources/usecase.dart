abstract class UseCase<Type, Params> {
  Future<Type> exec({Params params});
}