// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
//
// class SavedFoodDatabaseProvider {
//   static const String TABLE_POST = "savedfoods";
//   static const String COLUMN_ID = "column_id";
//   static const String COLUMN_UN_ID = "id";
//   static const String COLUMN_TITLE = "title";
//   static const String COLUMN_DESCRIPTION = "description";
//   static const String COLUMN_GALLERY = "gallery";
//   static const String COLUMN_STOCK = "stock_status";
//   static const String COLUMN_RATING = "average_rating";
//   static const String COLUMN_PRODUCT_PRICE = "product_price";
//   static const String COLUMN_ONSALE = "on_sale";
//   static const String COLUMN_IS_BOOKMARKED = "is_bookmark";
//
//   SavedFoodDatabaseProvider._();
//
//   static final SavedFoodDatabaseProvider db = SavedFoodDatabaseProvider._();
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
//       join(dbPath, 'wpmobilwoocommerceDB1.db'),
//       version: 1,
//       onCreate: (Database database, int version) async {
//         await database.execute(
//           "CREATE TABLE $TABLE_POST ("
//           "$COLUMN_ID INTEGER PRIMARY KEY,"
//           "$COLUMN_UN_ID TEXT,"
//           "$COLUMN_TITLE TEXT,"
//           "$COLUMN_STOCK TEXT,"
//           "$COLUMN_RATING TEXT,"
//           "$COLUMN_PRODUCT_PRICE TEXT,"
//           "$COLUMN_ONSALE TEXT,"
//           "$COLUMN_DESCRIPTION TEXT,"
//               "$COLUMN_GALLERY TEXT,"
//           "$COLUMN_IS_BOOKMARKED TEXT"
//           ")"
//         );
//       },
//     );
//   }
//
//   Future<List<ProductModel>> getSavedProducts() async {
//     final db = await database;
//     var posts = await db.query(TABLE_POST, columns: [
//       COLUMN_ID,
//       COLUMN_UN_ID,
//       COLUMN_TITLE,
//       COLUMN_STOCK,
//       COLUMN_RATING,
//       COLUMN_PRODUCT_PRICE,
//       COLUMN_ONSALE,
//       COLUMN_DESCRIPTION,
//       COLUMN_CATEGORY,
//       COLUMN_GALLERY,
//       COLUMN_IS_BOOKMARKED,
//     ]);
//
//     print("reached here $posts");
//
//     List<ProductModel> postList = List<ProductModel>();
//
//     print("reached after $posts");
//
//     posts.forEach((currentPost) {
//       print("posts is $currentPost");
//       ProductModel post = ProductModel.fromSQMap(currentPost);
//       print("after posts is $post");
//       postList.add(post);
//     });
//
//     return postList;
//   }
//
//   Future<ProductModel> insert(ProductModel savedProduct) async {
//     print("started db $savedProduct");
//     final db = await database;
//     savedProduct.column_id = await db.insert(TABLE_POST, savedProduct.toLocalMap());
//     print("ended db ${savedProduct.title}");
//     return savedProduct;
//   }
//
//
//
//   Future<int> delete(int id) async {
//     final db = await database;
//
//     return await db.delete(
//       TABLE_POST,
//       where: "column_id = ?",
//       whereArgs: [id],
//     );
//   }
//
//   Future<int> update(ProductModel updateSavedPost) async {
//     final db = await database;
//     var savedId = int.parse(updateSavedPost.id);
//
//     return await db.update(
//       TABLE_POST,
//       updateSavedPost.toLocalMap(),
//       where: "column_id = ?",
//       whereArgs: [savedId],
//     );
//   }
// }
