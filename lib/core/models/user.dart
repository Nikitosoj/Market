import '../../main.dart';

class User {
  late final String id;
  late final bool seller;
  late String email;
  late String phone;
  String? name;
  int? totalBuy;

  User setPhone(String phone) {
    this.phone = phone;
    return this;
  }

  User setTotalBuy(int totalBuy) {
    this.totalBuy = totalBuy;
    return this;
  }

  User setName(String name) {
    this.name = name;
    return this;
  }

  User setEmail(String email) {
    this.email = email;
    return this;
  }

  Future<User> update(
      {String? phone, String? email, String? name, int? totalBuy}) async {
    await supabase.from('Users').update({
      'email': email ?? this.email,
      'phone': phone ?? this.phone,
      'name': name ?? this.name,
      'total_buy': totalBuy ?? this.totalBuy,
    }).eq('phone', this.phone);
    Map<String, dynamic> user =
        await supabase.from('Users').select().eq('phone', this.phone).single();

    _setData(user: user, first: false);
    return this;
  }

  Future<User> getByEmail(String email) async {
    Map<String, dynamic> user =
        await supabase.from('Users').select().eq('email', email).single();
    _setData(user: user);
    return this;
  }

  void _setData({required Map<String, dynamic> user, bool first = true}) {
    phone = user['phone'] ?? phone;
    email = user['email'] ?? email;
    name = user['name'] ?? name;
    totalBuy = user['total_buy'] ?? totalBuy;
    if (first) {
      id = user['id'] ?? id;
      seller = user['seller'] ?? seller;
    }
  }

  Future<User?> create(
      String email, String password, String phone, bool seller) async {
    try {
      final res = await supabase
          .from('Users')
          .insert({
            'email': email,
            'encrypted_password': password,
            'phone': phone,
            'seller': seller,
          })
          .select()
          .single();

      if (res.isNotEmpty) {
        _setData(user: res);
        return this;
      } else {
        throw Exception("User data is null.");
      }
    } catch (e) {
      throw Exception("User creation failed: ${e.toString()}");
    }
  }
}
