import '../../../../core/models/user.dart';
import '../../../../main.dart';

Future<User?> checkUserData(String email, String password) async {
  try {
    final response = await supabase
        .from('Users')
        .select()
        .eq('email', email)
        .eq('encrypted_password', password);
    print('check user data = $response');
    if (response.isEmpty) {
      return null;
    } else {
      print('start getByemail');
      return await User().getByEmail(email);
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
