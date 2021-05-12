import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  postDependencies();
}

Future<void> postDependencies() async {
  // serviceLocator.registerFactory(() => CommentBloc(repository: serviceLocator()));

  // serviceLocator.registerFactory(() => PostDetailBloc(repository: serviceLocator()));

  // serviceLocator.registerFactory(
  //   () => PostListBloc(
  //     repository: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton(
  //   () => PostRepository(
  //     apiDataSource: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton(
  //   () => ApiDataSource(),
  // );
}
