import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:drift/drift.dart';

class CartDatasource {
  const new(this._database);
  final AppDatabase _database;

  Future<List<CartItemTableData>> getCartItems(int storeId) =>
      (_database.select(_database.cartItemTable)..where((t) => t.storeId.equals(storeId))).get();

  /// Adds one of the product to the store's cart, inserting it if it isn't there yet.
  Future<void> addProduct({required int storeId, required int productId}) {
    return _database
        .into(_database.cartItemTable)
        .insert(
          CartItemTableCompanion.insert(storeId: storeId, productId: productId, quantity: 1),
          onConflict: DoUpdate((old) => CartItemTableCompanion.custom(quantity: old.quantity + const Constant(1))),
        );
  }

  /// Takes one of the product off the store's cart, deleting the item when it was the last one.
  ///
  /// Runs in a transaction so that quick successive calls each take one off.
  Future<void> decreaseQuantity({required int storeId, required int productId}) {
    return _database.transaction(() async {
      await (_database.delete(_database.cartItemTable)..where(
            (t) => t.storeId.equals(storeId) & t.productId.equals(productId) & t.quantity.isSmallerOrEqualValue(1),
          ))
          .go();
      await (_database.update(_database.cartItemTable)
            ..where((t) => t.storeId.equals(storeId) & t.productId.equals(productId) & t.quantity.isBiggerThanValue(1)))
          .write(CartItemTableCompanion.custom(quantity: _database.cartItemTable.quantity - const Constant(1)));
    });
  }

  /// Puts the product in the basket, or takes it back out.
  ///
  /// Flips the stored value, so that quick successive calls each take effect.
  Future<void> toggleChecked({required int storeId, required int productId}) {
    return (_database.update(_database.cartItemTable)
          ..where((t) => t.storeId.equals(storeId) & t.productId.equals(productId)))
        .write(CartItemTableCompanion.custom(isChecked: _database.cartItemTable.isChecked.not()));
  }

  Future<bool> updateQuantity({required int storeId, required int productId, required int quantity}) async {
    final updatedRows =
        await (_database.update(_database.cartItemTable)
              ..where((t) => t.storeId.equals(storeId) & t.productId.equals(productId)))
            .write(CartItemTableCompanion(quantity: Value(quantity)));

    return updatedRows > 0;
  }

  Future<bool> removeProduct({required int storeId, required int productId}) async {
    final deletedRows = await (_database.delete(
      _database.cartItemTable,
    )..where((t) => t.storeId.equals(storeId) & t.productId.equals(productId))).go();

    return deletedRows > 0;
  }
}
