import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/core/models/cart_product.dart';
import 'package:style_hub/features/auth/presentation/auth_screen.dart';
import 'package:style_hub/features/cart/presentation/cart_screen.dart';
import 'package:style_hub/features/chats/presentation/chats_screen.dart';
import 'package:style_hub/features/payment/presentation/payment_screen.dart';
import 'package:style_hub/features/phone/presentation/phone_screen.dart';
import 'package:style_hub/features/profile/presentation/profile_screen.dart';
import 'package:style_hub/features/sing_up/presentation/sign_up_screen.dart';

import '../../auth_notifier.dart';
import '../add_product/presentation/add_product_screen.dart';
import '../catalog/presentation/catalog_screen.dart';
import '../chat_detail/presentation/chat_detail_screen.dart';
import '../error/presentation/error_screen.dart';
import '../product/presentation/product_screen.dart';
import 'presentation/root_screen.dart';

final router = GoRouter(
  initialLocation: '/phone',
  routes: [
    GoRoute(
        path: '/error',
        builder: (context, state) {
          final error = state.extra as String;
          return ErrorScreen(error: error);
        }),
    GoRoute(
        path: '/auth',
        builder: (context, state) {
          final phone = state.extra as String;
          return AuthScreen(
            phone: phone,
          );
        }),
    GoRoute(
        path: '/signUp',
        builder: (context, state) {
          final phone = state.extra as String;
          return SignUpScreen(phone: phone);
        }),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final productList = state.extra as List<CartProductModel>;
        return PaymentScreen(productList: productList);
      },
    ),
    GoRoute(
      path: '/phone',
      builder: (context, state) => const PhoneScreen(),
    ),
    // BottomNavigationBar
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/catalog',
                builder: (context, state) => const CatalogScreen(),
                routes: [
                  GoRoute(
                    path: 'product',
                    builder: (context, state) => const ProductScreen(),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/chats',
                builder: (context, state) => const ChatsScreen(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) => const ChatDetailScreen(),
                  )
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/seller',
              builder: (context, state) => const AddProductScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    final isAuthenticated = authNotifier.isAuthenticated;
    final isLoggingIn = state.matchedLocation == '/phone';

    if (!isAuthenticated && !isLoggingIn) return '/phone';
    if (isAuthenticated && isLoggingIn) return '/catalog';

    return null;
  },
);
