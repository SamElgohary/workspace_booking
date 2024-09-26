import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/booking.dart';
import '../../models/workspace.dart';
import '../../views/booking_view.dart';
import '../../views/confirmation_view.dart';
import '../../views/splash_view.dart';
import '../../views/workspace_detail_view.dart';
import '../../views/workspace_list_view.dart';

class RouterInitial {
  // Define a provider for GoRouter
  static final routerProvider = Provider<GoRouter>((ref) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashView(),
          routes: [
            GoRoute(
              path: 'home',
              builder: (context, state) => WorkspaceListView(),
              routes: [
                GoRoute(
                  path: 'workspace/:id',
                  builder: (context, state) {
                    final workspaceId = state.pathParameters['id']!;
                    final workspace = state.extra as Workspace;
                    return WorkspaceDetailView(workspace: workspace);
                  },
                  routes: [
                    GoRoute(
                      path: 'booking',
                      builder: (context, state) {
                        final workspace = state.extra as Workspace;
                        return BookingView(workspace: workspace);
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'confirmation',
              builder: (context, state) {
                final bookingData = state.extra as Map<String, dynamic>;
                final workspace = bookingData['workspace'] as Workspace;
                final booking = bookingData['booking'] as Booking;

                return ConfirmationView(
                  workspace: workspace,
                  booking: booking,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
  );
}
