// import 'database_model.dart';

// class User {
//   late final String id;
//   late final bool seller;
//   late String email;
//   late String phone;
//   String? name;
//   int? totalBuy;

//   final DatabaseModel database;

//   User({required this.database});

//   User setPhone(String phone) {
//     this.phone = phone;
//     return this;
//   }

//   User setTotalBuy(int totalBuy) {
//     this.totalBuy = totalBuy;
//     return this;
//   }

//   User setName(String name) {
//     this.name = name;
//     return this;
//   }

//   User setEmail(String email) {
//     this.email = email;
//     return this;
//   }

//   Future<User> update(
//       {String? phone, String? email, String? name, int? totalBuy}) async {
//     await database.update({
//       'email': email ?? this.email,
//       'phone': phone ?? this.phone,
//       'name': name ?? this.name,
//       'total_buy': totalBuy ?? this.totalBuy,
//     }, 'phone', this.phone);

//     Map<String, dynamic> user =
//         await database.selectSingle('phone', this.phone);

//     _setData(user: user, first: false);
//     return this;
//   }

//   Future<User> getByEmail(String email) async {
//     Map<String, dynamic> user = await database.selectSingle('email', email);
//     _setData(user: user);
//     return this;
//   }

//   void _setData({required Map<String, dynamic> user, bool first = true}) {
//     phone = user['phone'] ?? phone;
//     email = user['email'] ?? email;
//     name = user['name'] ?? name;
//     totalBuy = user['total_buy'] ?? totalBuy;
//     if (first) {
//       id = user['id'] ?? id;
//       seller = user['seller'] ?? seller;
//     }
//   }

//   Future<User?> create(
//       String email, String password, String phone, bool seller) async {
//     try {
//       final res = await database.insert({
//         'email': email,
//         'encrypted_password': password,
//         'phone': phone,
//         'seller': seller,
//       });

//       if (res.isNotEmpty) {
//         _setData(user: res);
//         return this;
//       } else {
//         throw Exception("User data is null.");
//       }
//     } catch (e) {
//       throw Exception("User creation failed: ${e.toString()}");
//     }
//   }
// }
class User {
  final String id;
  final bool seller;
  String email;
  String phone;
  String name;
  int totalBuy;

  User({
    required this.id,
    required this.seller,
    required this.email,
    required this.name,
    required this.phone,
    required this.totalBuy,
  });
}
