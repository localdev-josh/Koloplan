// import 'package:koloplan/data/models/search_activity/search_activity.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
//
// class UserSearchDatabaseProvider {
//   static const String TABLE_USER_SEARCH = "localsearches";
//   static const String COLUMN_ID = "column_id";
//   static const String COLUMN_UN_ID = "id";
//   static const String COLUMN_USER_SEARCH = "user_search";
//
//   UserSearchDatabaseProvider._();
//
//   static final UserSearchDatabaseProvider db = UserSearchDatabaseProvider._();
//
//   Database _database;
//
//   Future<Database> get database async {
//     print("database getter called");
//
//     if (_database != null) {
//       return _database;
//     }
//
//     _database = await createDatabase();
//
//     return _database;
//   }
//
//   Future<Database> createDatabase() async {
//     String dbPath = await getDatabasesPath();
//
//     return await openDatabase(
//       join(dbPath, 'GrubswipeLocalSearchDB.db'),
//       version: 1,
//       onCreate: (Database database, int version) async {
//         await database.execute(
//             "CREATE TABLE $TABLE_USER_SEARCH ("
//                 "$COLUMN_ID INTEGER PRIMARY KEY,"
//                 "$COLUMN_UN_ID TEXT,"
//                 "$COLUMN_USER_SEARCH TEXT"
//                 ")"
//         );
//       },
//     );
//   }
//
//   Future<List<SearchActivityItem>> getSavedSearches() async {
//     final db = await database;
//     var userSearches = await db.query(TABLE_USER_SEARCH, columns: [
//       COLUMN_ID,
//       COLUMN_UN_ID,
//       COLUMN_USER_SEARCH,
//     ]);
//
//     print("reached here $userSearches");
//
//     List<SearchActivityItem> searchList = List<SearchActivityItem>();
//
//     print("reached after $userSearches");
//
//     userSearches.forEach((currentSearch) {
//       print("searches are $currentSearch");
//       SearchActivityItem searches = SearchActivityItem.fromSQMap(currentSearch);
//       print("after search is $searches");
//       searchList.add(searches);
//     });
//
//     return searchList;
//   }
//
//   Future<SearchActivityItem> insert(SearchActivityItem userSearch) async {
//     print("started db $userSearch");
//     final db = await database;
//     userSearch.column_id = await db.insert(TABLE_USER_SEARCH, userSearch.toLocalMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//     print("ended db ${userSearch.user_search}");
//     return userSearch;
//   }
//
//
//
//   Future<int> delete(int id) async {
//     final db = await database;
//
//     return await db.delete(
//       TABLE_USER_SEARCH,
//       where: "column_id = ?",
//       whereArgs: [id],
//     );
//   }
//
//   Future<int> update(SearchActivityItem updateUserSearch) async {
//     final db = await database;
//     var savedId = updateUserSearch.id;
//
//     print("Update saved after is ${updateUserSearch.user_search}");
//
//     return await db.update(
//       TABLE_USER_SEARCH,
//       updateUserSearch.toLocalMap(),
//       where: "column_id = ?",
//       whereArgs: [savedId],
//     );
//   }
// }
