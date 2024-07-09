import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recything_mobile/bloc/auth/auth_cubit.dart';
import 'package:recything_mobile/bloc/claim_mission/claim_mission_cubit.dart';
import 'package:recything_mobile/bloc/dynamic_link/dynamic_link_cubit.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:recything_mobile/bloc/get_ai/get_ai_cubit.dart';
import 'package:recything_mobile/bloc/get_all_drop_point/get_all_drop_point_cubit.dart';
import 'package:recything_mobile/bloc/get_all_event/get_all_event_cubit.dart';
import 'package:recything_mobile/bloc/get_detail_event/get_detail_event_cubit.dart';
import 'package:recything_mobile/bloc/get_history_poin/get_history_poin_cubit.dart';
import 'package:recything_mobile/bloc/get_history_poin_by_id/get_history_poin_by_id_cubit.dart';
import 'package:recything_mobile/bloc/get_community/community_cubit.dart';
import 'package:recything_mobile/bloc/get_community_by_id/community_by_id_cubit.dart';
import 'package:recything_mobile/bloc/get_history_report_by_id/get_history_report_by_id_cubit.dart';
import 'package:recything_mobile/bloc/get_lencana/get_lencana_cubit.dart';
import 'package:recything_mobile/bloc/get_missions/get_missions_cubit.dart';
import 'package:recything_mobile/bloc/get_poin_daily/get_poin_daily_cubit.dart';
import 'package:recything_mobile/bloc/get_report_hisstory/get_report_history_cubit.dart';
import 'package:recything_mobile/bloc/get_user_profile/get_user_profile_cubit.dart';
import 'package:recything_mobile/bloc/get_vouchers/get_vouchers_cubit.dart';
import 'package:recything_mobile/bloc/join_community/join_community_cubit.dart';
import 'package:recything_mobile/bloc/login/login_cubit.dart';
import 'package:recything_mobile/bloc/get_all_faq/get_all_faq_cubit.dart';
import 'package:recything_mobile/bloc/post_like/post_like_article_cubit.dart';
import 'package:recything_mobile/bloc/post_poin_daily/post_poin_daily_cubit.dart';
import 'package:recything_mobile/bloc/post_report/post_report_rubbish_cubit.dart';
import 'package:recything_mobile/bloc/post_report_littering/post_report_littering_cubit.dart';
import 'package:recything_mobile/bloc/post_voucher/post_voucher_cubit.dart';
import 'package:recything_mobile/bloc/update_user_profile/update_user_profile_cubit.dart';
import 'package:recything_mobile/bloc/register/register_cubit.dart';
import 'package:recything_mobile/bloc/update_password/update_password_cubit.dart';
import 'package:recything_mobile/bloc/upload_proof/upload_proof_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/firebase_options.dart';
import 'package:recything_mobile/screens/article/page/artikel_by_kategori.dart';
import 'package:recything_mobile/screens/article/page/cari_artikel.dart';
import 'package:recything_mobile/screens/article/page/daftar_lokasi.dart';
import 'package:recything_mobile/screens/article/page/detail_artikel.dart';
import 'package:recything_mobile/screens/article/page/kategori_daur_ulang_screen.dart';
import 'package:recything_mobile/screens/article/page/search_article_screen.dart';
import 'package:recything_mobile/screens/dashboard.dart';
import 'package:recything_mobile/screens/home/pages/notifikasi_screen.dart';
import 'package:recything_mobile/screens/home/pages/pertanyaan_umum_screen.dart';
import 'package:recything_mobile/screens/home/pages/profile_screen.dart';
import 'package:recything_mobile/screens/home/pages/ubah_password_screen.dart';
import 'package:recything_mobile/screens/index_screen.dart';
import 'package:recything_mobile/screens/komunitas/rekomendasi_komunitas_screen.dart';
import 'package:recything_mobile/screens/login/login_screen.dart';
import 'package:recything_mobile/screens/missions/detail_mission_screen.dart';
import 'package:recything_mobile/screens/missions/missions_screen.dart';
import 'package:recything_mobile/screens/missions/unggah_bukti_screen.dart';
import 'package:recything_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:recything_mobile/screens/password_baru/password_baru_screen.dart';
import 'package:recything_mobile/screens/poinku/pages/detail_voucher_screen.dart';
import 'package:recything_mobile/screens/recy/pages/recy_ai_screen.dart';
import 'package:recything_mobile/screens/register/register_screen.dart';
import 'package:recything_mobile/screens/report/choose_report_screen.dart';
import 'package:recything_mobile/screens/report/report-rubbish/detail_riwayat_pelaporan_screen.dart';
import 'package:recything_mobile/screens/report/report-rubbish/report_rubbish_screen.dart';
import 'package:recything_mobile/screens/report/widget/maps_report_screen.dart';
import 'package:recything_mobile/screens/report/report_littering/report_littering_screen.dart';
import 'package:recything_mobile/screens/reset_password/reset_password_screen.dart';
import 'package:recything_mobile/screens/splash/splash_screen.dart';
import 'package:recything_mobile/screens/verifikasi_otp/verifikasi_otp_screen.dart';
import 'package:flutter_config/flutter_config.dart';
import 'bloc/get_article/get_article_cubit.dart';
import 'bloc/get_popular_article/get_popular_article_cubit.dart';
import 'bloc/recyBot/post_recy_bot_cubit.dart';

// runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => const MyApp(),
//   ),

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(),
  // ));

  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()..appStarted()),
        BlocProvider(create: (_) => GetAiCubit()),
        BlocProvider(create: (_) => GetAllFaqCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => GetUserProfileCubit()),
        BlocProvider(create: (_) => UpdateUserProfileCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => ForgotPasswordCubit()),
        BlocProvider(create: (_) => GetReportHistoryCubit()),
        BlocProvider(create: (_) => GetHistoryReportByIdCubit()),
        BlocProvider(create: (_) => UpdatePasswordCubit()),
        BlocProvider(create: (_) => PostReportRubbishCubit()),
        BlocProvider(create: (_) => PostRecyBotCubit()),
        BlocProvider(create: (_) => GetArticleCubit()),
        BlocProvider(create: (_) => GetPopularArticleCubit()),
        BlocProvider(create: (_) => GetVouchersCubit()),
        BlocProvider(create: (_) => PostReportLitteringCubit()),
        BlocProvider(create: (_) => GetMissionsCubit()),
        BlocProvider(create: (_) => GetAllDropPointCubit()),
        BlocProvider(create: (_) => GetLencanaCubit()),
        BlocProvider(create: (_) => GetHistoryPoinCubit()),
        BlocProvider(create: (_) => PostVoucherCubit()),
        BlocProvider(create: (_) => PostPoinDailyCubit()),
        BlocProvider(create: (_) => GetHistoryPoinCubit()),
        BlocProvider(create: (_) => GetHistoryPoinByIdCubit()),
        BlocProvider(create: (_) => ClaimMissionCubit()),

        // BlocProvider(create: (_) => ValueIsPopularCubit()),
        // BlocProvider(create: (_) => OnSearchCubit())
        BlocProvider(create: (_) => CommunityCubit()),
        BlocProvider(create: (_) => CommunityByIdCubit()),
        BlocProvider(create: (_) => JoinCommunityCubit()),
        BlocProvider(create: (_) => GetPoinDailyCubit()),
        BlocProvider(create: (_) => ClaimMissionCubit()),
        BlocProvider(create: (_) => UploadProofCubit()),
        BlocProvider(create: (_) => PostLikeArticleCubit()),
        BlocProvider(create: (_) => GetAllEventCubit()),
        BlocProvider(create: (_) => GetDetailEventCubit()),
        BlocProvider(create: (_) => DynamicLinkCubit()),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Pallete.textMainButton,
          fontFamily: "Inter",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        initialRoute: '/index',
        home: const IndexScreen(),
        routes: {
          '/index': (context) => const IndexScreen(),
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/missions': (context) => const MissionsScreen(),
          '/detail-mission': (context) => const DetailMissionScreen(),
          '/unggah-bukti': (context) => const UnggahBuktiScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const Dasboard(),
          '/dashboard-mission': (context) => const Dasboard(
                index: 3,
              ),
          '/profile': (context) => const ProfileScreen(),
          '/notif': (context) => const NotifikasiScreen(),
          '/detailVoucher': (context) => const DetailVoucherScreen(),
          '/register': (context) => const RegisterScreen(),
          '/reset_password': (context) => const ResetPasswordScreen(),
          '/verifikasi_otp': (context) => const VerifikasiOtpScreen(),
          '/password_baru': (context) => const PasswordBaruScreen(),
          '/pertanyaanUmum': (context) => const PertanyaanUmumScren(),
          '/ubahPassword': (context) => const UbahPasswordScreen(),
          '/recy': (context) => const RecyAiScreen(),
          '/choose-report': (context) => const ChooseReportScreen(),
          '/report-rubbish': (context) => const ReportRubbishScreen(),
          '/report-littering': (context) => const ReportLitteringScreen(),
          '/detail-report': (context) => const DetailRiwayatPelaporanScreen(),
          '/maps-report': (context) => const MapsReportScreen(reportType: ''),
          '/artikelByKategori': (context) => const ArtikelByKategoriScreen(),
          '/kategoriDaurUlang': (context) => const KategoriDaurUlangScreen(),
          '/cariArtikel': (context) => const CariArtikelScreen(),
          '/daftarLokasi': (context) => const DaftarLokasiScreen(),
          '/detailArtikel': (context) => const DetailArtikelScreen(),
          '/semua-komunitas': (context) => const RekomendasiKomunitasScreen(),
          '/searchArtikelScreen': (context) => const SearchArticleScreen()
        },
      ),
    );
  }
}
