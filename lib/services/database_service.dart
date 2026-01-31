import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/index.dart';

/// [DatabaseService] manages the local SQLite storage for offline capabilities.
/// It uses a singleton pattern and ensures safe database initialization.
class DatabaseService {
  static const String dbName = 'nexus_tracker.db';
  static const int dbVersion = 1;

  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Database? _db;

  /// Get the database instance, initializing it if necessary.
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // --- Table: Users ---
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        department TEXT NOT NULL,
        jobTitle TEXT NOT NULL,
        joinDate TEXT NOT NULL,
        phone TEXT,
        overallScore REAL DEFAULT 0.0
      )
    ''');

    // --- Table: Courses ---
    await db.execute('''
      CREATE TABLE courses (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        instructor TEXT NOT NULL,
        category TEXT,
        durationMinutes INTEGER,
        rating REAL DEFAULT 0.0,
        enrollmentCount INTEGER DEFAULT 0,
        createdDate TEXT NOT NULL
      )
    ''');

    // --- Table: Enrollments ---
    await db.execute('''
      CREATE TABLE enrollments (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        courseId TEXT NOT NULL,
        enrollDate TEXT NOT NULL,
        completionDate TEXT,
        progressPercentage REAL DEFAULT 0.0,
        status TEXT DEFAULT 'active',
        score REAL DEFAULT 0.0,
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (courseId) REFERENCES courses(id)
      )
    ''');

    // --- Table: Certificates ---
    await db.execute('''
      CREATE TABLE certificates (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        courseId TEXT NOT NULL,
        title TEXT NOT NULL,
        certificateNumber TEXT UNIQUE,
        issuedDate TEXT NOT NULL,
        expiryDate TEXT,
        issuer TEXT NOT NULL,
        isVerified INTEGER DEFAULT 1,
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (courseId) REFERENCES courses(id)
      )
    ''');

    // --- Table: Test Results ---
    await db.execute('''
      CREATE TABLE test_results (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        assessmentId TEXT NOT NULL,
        attemptDate TEXT NOT NULL,
        scorePercentage REAL NOT NULL,
        correctAnswers INTEGER,
        totalQuestions INTEGER,
        timeSpentSeconds INTEGER,
        isPassed INTEGER DEFAULT 0,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Logic for database migrations can be added here
  }

  // --- CRUD Operations: Users ---

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'id': user.id,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'department': user.department,
        'jobTitle': user.jobTitle,
        'joinDate': user.joinDate.toIso8601String(),
        'phone': user.phone,
        'overallScore': user.overallScore,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return User(
        id: result[0]['id'] as String,
        firstName: result[0]['firstName'] as String,
        lastName: result[0]['lastName'] as String,
        email: result[0]['email'] as String,
        department: result[0]['department'] as String,
        jobTitle: result[0]['jobTitle'] as String,
        joinDate: DateTime.parse(result[0]['joinDate'] as String),
        phone: result[0]['phone'] as String?,
        overallScore: (result[0]['overallScore'] as num?)?.toDouble() ?? 0.0,
      );
    }
    return null;
  }

  // --- CRUD Operations: Courses ---

  Future<void> insertCourse(Course course) async {
    final db = await database;
    await db.insert(
      'courses',
      {
        'id': course.id,
        'title': course.title,
        'description': course.description,
        'instructor': course.instructor,
        'category': course.category,
        'durationMinutes': course.durationMinutes,
        'rating': course.rating,
        'enrollmentCount': course.enrollmentCount,
        'createdDate': course.createdDate.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Course>> getAllCourses() async {
    final db = await database;
    final result = await db.query('courses');
    return result.map((row) {
      return Course(
        id: row['id'] as String,
        title: row['title'] as String,
        description: (row['description'] as String?) ?? '',
        instructor: row['instructor'] as String,
        category: (row['category'] as String?) ?? 'General',
        durationMinutes: (row['durationMinutes'] as int?) ?? 0,
        rating: (row['rating'] as num?)?.toDouble() ?? 0.0,
        enrollmentCount: (row['enrollmentCount'] as int?) ?? 0,
        createdDate: DateTime.parse(row['createdDate'] as String),
      );
    }).toList();
  }

  // --- CRUD Operations: Enrollments ---

  Future<void> insertEnrollment(Enrollment enrollment) async {
    final db = await database;
    await db.insert(
      'enrollments',
      {
        'id': enrollment.id,
        'userId': enrollment.userId,
        'courseId': enrollment.courseId,
        'enrollDate': enrollment.enrollDate.toIso8601String(),
        'completionDate': enrollment.completionDate?.toIso8601String(),
        'progressPercentage': enrollment.progressPercentage,
        'status': enrollment.status,
        'score': enrollment.score,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --- CRUD Operations: Certificates ---

  Future<void> insertCertificate(Certificate certificate) async {
    final db = await database;
    await db.insert(
      'certificates',
      {
        'id': certificate.id,
        'userId': certificate.userId,
        'courseId': certificate.courseId,
        'title': certificate.title,
        'certificateNumber': certificate.certificateNumber,
        'issuedDate': certificate.issuedDate.toIso8601String(),
        'expiryDate': certificate.expiryDate?.toIso8601String(),
        'issuer': certificate.issuer,
        'isVerified': certificate.isVerified ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Certificate>> getUserCertificates(String userId) async {
    final db = await database;
    final result = await db.query(
      'certificates',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return result.map((row) {
      return Certificate(
        id: row['id'] as String,
        userId: row['userId'] as String,
        courseId: row['courseId'] as String,
        title: row['title'] as String,
        certificateNumber: row['certificateNumber'] as String,
        issuedDate: DateTime.parse(row['issuedDate'] as String),
        expiryDate: row['expiryDate'] != null
            ? DateTime.parse(row['expiryDate'] as String)
            : null,
        issuer: row['issuer'] as String,
        isVerified: (row['isVerified'] as int?) == 1,
      );
    }).toList();
  }

  /// Explicitly close the database connection.
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
