import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_product.dart';
import 'comment.dart';
import 'product.dart';
import 'user.dart';

abstract class DatabaseModel {
  Future<User?> getUserData(String userId, String email);
  Future<User?> createUserData(
      String userId, String email, String phone, bool seller);
  Future<List<CartProductModel>> getUserCart(String userId);
  Future<Product> getProductById(String id);
  Future<bool> deleteProductFromCart(String cartProductId, String userId);
  Future<bool> addProductToCart(Product item, String userId, String sizeName);
  Future<List<Product>> getProductList();
  Future<bool> addNewProduct(Map<String, dynamic> map, List<String> sizes);
  Future<String?> addUserPayment(
      String userId, int amount, String status, String method);
  Future<bool> addOrder(
      String userId, List<Product> products, String paymentId);
  Future<bool> isUserExistsByPhone(String phone);
  Future<List<CommentModel>> getComments(String productId);
  Future<bool> checkCanComment(String userId, String productId);
  Future<void> updateUserName(String userId, String name);
}

class FirebaseModel extends DatabaseModel {
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<User?> getUserData(String userId, String email) async {
    try {
      DocumentSnapshot userDoc =
          await fireStore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        // Данные документа в виде Map
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return User(
            id: userId,
            seller: userData['seller'],
            email: email,
            name: userData['name'],
            phone: userData['phone'],
            totalBuy: userData['total_buy']);
      } else {
        print('Документ пользователя не найден.');
        return null;
      }
    } catch (e) {
      print('Ошибка при получении данных пользователя: $e');
      return null;
    }
  }

  @override
  Future<User?> createUserData(
      String userId, String email, String phone, bool seller) async {
    try {
      await fireStore.collection('Users').doc(userId).set({
        'name': 'anon',
        'phone': phone,
        'seller': seller,
        'total_buy': 0,
        'created_at': FieldValue.serverTimestamp()
      });
      final user = await getUserData(userId, email);
      if (user != null) {
        return user;
      } else {
        print('Ошибка при добавлении пользователя: ');
        return null;
      }
    } catch (e) {
      print('Ошибка при добавлении пользователя: $e');
      return null;
    }
  }

  @override
  Future<List<CartProductModel>> getUserCart(String userId) async {
    List<CartProductModel> cartItems = [];
    try {
      final snapshot = await fireStore
          .collection('Users')
          .doc(userId)
          .collection('Cart')
          .get();
      final snapshotData = snapshot.docs.map((doc) => doc.data()).toList();

      for (int i = 0; i < snapshotData.length; i++) {
        final product =
            await getProductById(snapshotData[i]['product_id'].toString());
        cartItems.add(CartProductModel(
            id: snapshot.docs[i].id,
            product: product,
            sizeSelected: snapshotData[i]['size_name']));
      }
    } catch (e) {
      print('error $e');
    }
    return cartItems;
  }

  @override
  Future<Product> getProductById(String id) async {
    List<String> sizes = [];
    DocumentSnapshot productDoc =
        await fireStore.collection('Product').doc(id).get();
    final sizesDoc =
        await fireStore.collection('Product').doc(id).collection('sizes').get();
    sizes = sizesDoc.docs.map((doc) => doc['name'] as String).toList();
    if (productDoc.exists) {
      Map<String, dynamic> productData =
          productDoc.data() as Map<String, dynamic>;
      return Product.fromMap(productData, id, sizes);
    }
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProductFromCart(
      String cartProductId, String userId) async {
    try {
      await fireStore
          .collection('Users')
          .doc(userId)
          .collection('Cart')
          .doc(cartProductId)
          .delete();
      return true;
    } on Exception catch (e) {
      print('$e');
      return false;
    }
  }

  @override
  Future<bool> addProductToCart(
      Product item, String userId, String sizeName) async {
    try {
      await fireStore.collection('Users').doc(userId).collection('Cart').add({
        'product_id': item.id,
        'quantity': 1,
        'size_name': sizeName,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<Product>> getProductList() async {
    List<Product> productList = [];
    List<String> sizes = [];
    try {
      final snapshot = await fireStore.collection('Product').limit(20).get();
      final products = snapshot.docs.map((doc) => doc.data()).toList();
      for (int i = 0; i < products.length; i++) {
        final sizesDoc = await fireStore
            .collection('Product')
            .doc(snapshot.docs[i].id)
            .collection('sizes')
            .get();
        sizes = sizesDoc.docs.map((doc) => doc['name'] as String).toList();
        productList
            .add(Product.fromMap(products[i], snapshot.docs[i].id, sizes));
      }
      return productList;
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> addNewProduct(
      Map<String, dynamic> map, List<String> sizes) async {
    try {
      final productRef = await fireStore.collection('Product').add(map);
      for (final size in sizes) {
        await productRef.collection('sizes').add({'name': size});
      }
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<String?> addUserPayment(
      String userId, int amount, String status, String method) async {
    try {
      final result = await fireStore
          .collection('Users')
          .doc(userId)
          .collection('Payments')
          .add({
        'amount': amount,
        'status': status,
        'method': method,
        'created_at': FieldValue.serverTimestamp(),
      });
      return result.id;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<bool> addOrder(
      String userId, List<Product> products, String paymentId) async {
    try {
      for (final item in products) {
        await fireStore
            .collection('Users')
            .doc(userId)
            .collection('Orders')
            .add({
          'product_id': item.id,
          'price': item.price,
          'payment_id': paymentId,
          'quantity': 1,
          'created_at': FieldValue.serverTimestamp(),
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> isUserExistsByPhone(String phone) async {
    try {
      final result = await fireStore
          .collection('Users')
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();
      if (result.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<CommentModel>> getComments(String productId) async {
    try {
      List<CommentModel> finalList = [];
      final result = await fireStore
          .collection('Product')
          .doc(productId)
          .collection('Comments')
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        final futures = result.docs.map((doc) async {
          final data = doc.data();
          final userDoc =
              await fireStore.collection('Users').doc(data['user_id']).get();
          return CommentModel(
            userName: userDoc['name'] ?? 'anon',
            stars: (data['stars'] as num).toDouble(),
            comment: data['comment'],
          );
        });
        finalList = await Future.wait(futures);
      }
      return finalList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<bool> checkCanComment(String userId, String productId) async {
    print('userId = $userId,productId = $productId');
    final result = await fireStore
        .collection('Product')
        .doc(productId)
        .collection('Comments')
        .doc(userId)
        .get();
    if (result.exists) {
      return false;
    } else {
      final isBuy = await fireStore
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .where('product_id', isEqualTo: productId)
          .limit(1)
          .get();
      if (isBuy.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Future<void> updateUserName(String userId, String name) async {
    await fireStore.collection('Users').doc(userId).update({'name': name});
  }
}
