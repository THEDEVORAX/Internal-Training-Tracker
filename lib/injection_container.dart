import 'package:get_it/get_it.dart';
import 'repositories/index.dart';
import 'services/index.dart';
import 'providers/app_provider.dart';
import 'providers/course_provider.dart';
import 'providers/assessment_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Services ---
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService());

  // --- Repositories ---
  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(
      apiService: sl(),
      databaseService: sl(),
    ),
  );
  sl.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(
      apiService: sl(),
      databaseService: sl(),
    ),
  );

  // --- Providers ---
  sl.registerFactory(() => AppProvider());
  sl.registerFactory(() => CourseProvider(repository: sl()));
  sl.registerFactory(() => AssessmentProvider(repository: sl()));
}
