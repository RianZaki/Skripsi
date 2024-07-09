import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/screens/home/pages/edit_profile_screen.dart';
import 'package:recything_mobile/screens/lencana/pages/lencana_screen.dart';
import 'package:recything_mobile/widgets/forms/custom_teks.dart';

class ProfileInformasiAkun extends StatelessWidget {
  final UserModel user;
  const ProfileInformasiAkun({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Informasi Akun", style: ThemeFont.bodyNormalSemiBold),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: const Icon(
              IconlyLight.profile,
              size: 24,
              color: Pallete.dark3,
            ),
            title: Row(
              children: [
                Text(
                  "Profile Saya",
                  style: ThemeFont.bodyNormalReguler,
                ),
                const SizedBox(
                  width: 8,
                ),
                if ((user.dateOfBirth == "") ||
                    (user.purpose == "") ||
                    (user.address == ""))
                  const CustomTeks(
                    name: "Lengkapi Profile",
                    color: Pallete.error,
                    size: 8,
                  )
              ],
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: user)));
                  // Navigator.pushNamed(context, '/editProfile', );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: const Icon(
              IconlyLight.lock,
              size: 24,
              color: Pallete.dark3,
            ),
            title: Text(
              "Ubah Password",
              style: ThemeFont.bodyNormalReguler,
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ubahPassword');
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Image.asset(
              "assets/icons/profile/poinku.png",
              width: 24,
            ),
            title: Text(
              "Poinku",
              style: ThemeFont.bodyNormalReguler,
            ),
            trailing: CustomTeks(
              name: user.point.toString(),
              color: Pallete.main,
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LencanaScreen(user: user)));
            },
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                leading: Image.asset(
                  "assets/icons/profile/lencana.png",
                  width: 24,
                ),
                title: Text(
                  "Lencana",
                  style: ThemeFont.bodyNormalReguler,
                ),
                trailing: CustomTeks(
                    name: user.badge ?? "bronze",
                    color: _getBadgeColor(user.badge ?? "bronze"))),
          ),
          const Divider()
        ],
      ),
    );
  }
}

Color _getBadgeColor(String badge) {
  switch (badge) {
    case 'platinum':
      return Pallete.platinum;
    case 'gold':
      return Pallete.gold;
    case 'silver':
      return Pallete.silver;
    case 'bronze':
      return Pallete.bronze;
    default:
      return Pallete.secondaryDarker;
  }
}
