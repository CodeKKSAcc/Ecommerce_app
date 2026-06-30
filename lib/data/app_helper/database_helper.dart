import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/wishlist_product_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper onlyInstance() {
    return DatabaseHelper._();
  }

  Database? database;

  String dbName = "Ecom.db";

  String tableName = "ECOMMERCE";

  static String column_product_image = "product_image";
  static String column_product_name = "product_name";
  static String column_product_price = "product_price";
  static String column_product_id = "product_id";
  static String column_product_liked = "product_liked";

  Future<Database> initDb() async {
    database ??= await openDb();
    return database!;
  }

  Future<Database> openDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (myDb, version) {
        myDb.execute(
          "Create table $tableName ("
          "$column_product_id integer primary key,"
          "$column_product_name text,"
          "$column_product_price real,"
          "$column_product_image text,"
          "$column_product_liked integer)",
        );
      },
    );
  }

  Future<bool> addWishlistProduct(WishlistProductModel myData) async {
    Database dbReference = await initDb();

    if(await isWishlistProductExists(myData.productId)){

      return false;

    } else {

      int rowsEff = await dbReference.insert(tableName, myData.toMap());

      return rowsEff > 0;
    }
  }

  Future<bool> isWishlistProductExists(int productId) async {

    Database dbReference = await initDb();

    List<Map<String,dynamic>> data = await dbReference.query(
      tableName,
      where: "$column_product_id = ?",
      whereArgs: [productId],
    );

    return data.isNotEmpty;
  }

  Future<List<WishlistProductModel>> fetchWishlistProduct() async {
    Database dbReference = await initDb();

    List<WishlistProductModel> allProducts = [];

    List<Map<String, dynamic>> likedProducts = await dbReference.query(
      tableName,
    );

    for (Map<String, dynamic> product in likedProducts) {
      allProducts.add(WishlistProductModel.fromMap(product));
    }

    return allProducts;
  }

  Future<bool> deleteWishlistProduct({required int productId}) async{

    Database dbReference = await initDb();

    int rowsEff = await dbReference.delete(tableName, where: "$column_product_id = ?", whereArgs: [productId]);

    return rowsEff > 0;
  }

}
