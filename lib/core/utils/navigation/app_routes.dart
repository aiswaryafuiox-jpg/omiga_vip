import 'package:get/get.dart';
import '../../../presentation/view/navigation_shell_view.dart';
import '../../../presentation/view/login_view.dart';
import '../../../presentation/view/splash_view.dart';
import '../../../presentation/view/faq_view.dart';
import '../../../presentation/view/terms_view.dart';
import '../../../presentation/view/settings_view.dart';
import '../../../presentation/view/profile_info_view.dart';
import '../../../presentation/view/change_password_view.dart';
import '../../../presentation/view/product_detail_view.dart';
import '../../../presentation/view/support_view.dart';
import '../../../presentation/view/admin_request_view.dart';
import '../../../presentation/view/privacy_view.dart';
import '../../../presentation/view/web_login_view.dart';
import '../../../presentation/controller/login_controller.dart';
import '../../../presentation/controller/navigation_controller.dart';
import '../../../presentation/controller/dashboard_controller.dart';
import '../../../presentation/controller/products_controller.dart';
import '../../../presentation/controller/support_controller.dart';
import '../../../presentation/controller/faq_controller.dart';
import '../../../presentation/controller/settings_controller.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String faq = '/faq';
  static const String terms = '/terms';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String changePassword = '/changePassword';
  static const String productDetail = '/productDetail';
  static const String support = '/support';
  static const String adminRequest = '/adminRequest';
  static const String privacy = '/privacy';
  static const String webLogin = '/webLogin';

  static List<GetPage<dynamic>> get pages => [
        GetPage(
          name: initial,
          page: () => const SplashView(),
        ),
        GetPage(
          name: login,
          page: () => const LoginView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => LoginController());
          }),
        ),
        GetPage(
          name: home,
          page: () => const NavigationShellView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => NavigationController());
            Get.lazyPut(() => DashboardController());
            Get.lazyPut(() => ProductsController());
            Get.lazyPut(() => SupportController());
          }),
        ),

        GetPage(
          name: faq,
          page: () => const FAQView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => FAQController());
          }),
        ),
        GetPage(
          name: terms,
          page: () => const TermsView(),
        ),
        GetPage(
          name: settings,
          page: () => const SettingsView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => SettingsController());
          }),
        ),
        GetPage(
          name: profile,
          page: () => const ProfileInfoView(),
        ),
        GetPage(
          name: changePassword,
          page: () => const ChangePasswordView(),
        ),
        GetPage(
          name: productDetail,
          page: () => const ProductDetailView(),
        ),
        GetPage(
          name: support,
          page: () => const SupportView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => SupportController());
          }),
        ),
        GetPage(
          name: adminRequest,
          page: () => const AdminRequestView(),
        ),
        GetPage(
          name: privacy,
          page: () => const PrivacyView(),
        ),
        GetPage(
          name: webLogin,
          page: () => const WebLoginView(),
        ),
      ];
}