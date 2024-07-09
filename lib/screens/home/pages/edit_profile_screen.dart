import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/bloc/update_user_profile/update_user_profile_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';
import 'package:recything_mobile/widgets/forms/main_button.dart';
import 'package:recything_mobile/widgets/forms/main_textfield.dart';
import 'package:recything_mobile/widgets/success_snackbar.dart';

import '../../../widgets/error_snackbar.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameEcd = TextEditingController();
  TextEditingController emailEcd = TextEditingController();
  TextEditingController alamatEcd = TextEditingController();
  String _dateController = "Masukan tanggal lahir";

  @override
  void initState() {
    nameEcd = TextEditingController(text: widget.user.fullname);
    emailEcd = TextEditingController(text: widget.user.email);
    alamatEcd = TextEditingController(text: widget.user.address);
    _dateController = widget.user.dateOfBirth;
    super.initState();
  }

  Future<void> selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    setState(() {
      _dateController =
          DateFormat('yyyy-MM-dd').format(selectedDate ?? DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          "Edit Profile",
          style: ThemeFont.heading6Medium,
        ),
        centerTitle: true,
        backgroundColor: Pallete.textMainButton,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<UpdateUserProfileCubit, UpdateUserProfileState>(
            listener: (context, state) {
              if (state is UpdateUserProfileLoading) {
                const CircularProgressIndicator();
              } else if (state is UpdateUserProfileFailure) {
                ErrorSnackbar.showSnackbar(
                  context,
                  title: "Oops, Gagal Memperbarui",
                  message: state.message,
                );
              } else if (state is UpdateUserProfileSuccess) {
                SuccessSnackbar.showSnackbar(context,
                    message: "Data profil Anda berhasil disimpan",
                    title: "Berhasil Menyimpan!");
                Navigator.pushNamed(context, '/profile');
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 69, 196, 169),
                        shape: BoxShape.circle),
                    child: Text(
                      widget.user.fullname.characters.first,
                      style: ThemeFont.heading3Bold.copyWith(
                          fontSize: 60, color: Pallete.textMainButton),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, top: 40),
                  child:
                      Text("Detail Akun", style: ThemeFont.bodyNormalSemiBold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MainTextField(
                    controller: nameEcd,
                    label: "Nama Lengkap",
                    prefixIcon: IconlyLight.profile,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MainTextField(
                    controller: emailEcd,
                    enable: false,
                    label: "email",
                    prefixIcon: IconlyLight.message,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MainTextField(
                    controller: alamatEcd,
                    maxLines: 4,
                    label: "Alamat",
                    prefixIcon: IconlyLight.location,
                  ),
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: selectDate,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16, top: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Pallete.dark3)),
                        child: MainTextField(
                          enable: false,
                          label: _dateController,
                          prefixIcon: IconlyLight.calendar,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: Container(
                        child: Text(
                          " Tanggal Lahir ",
                          style: ThemeFont.bodySmallRegular.copyWith(
                              fontSize: 12, color: Pallete.textSecondary),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.9,
                    initialSelection: tujuanList.contains(widget.user.purpose)
                        ? widget.user.purpose
                        : tujuanList.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        widget.user.purpose = value!;
                      });
                    },
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    label: const Text("Tujuan"),
                    leadingIcon: const Icon(IconlyLight.document),
                    dropdownMenuEntries: tujuanList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MainButton(
                          onPressed: () {
                            context
                                .read<UpdateUserProfileCubit>()
                                .updateProfile(
                                    context: context,
                                    fullname: nameEcd.text,
                                    address: alamatEcd.text,
                                    date: _dateController,
                                    purpose: widget.user.purpose);
                          },
                          child: Text(
                            "Simpan",
                            style: ThemeFont.heading6Reguler.copyWith(
                                color: Pallete.textMainButton,
                                fontWeight: FontWeight.w700),
                          ))),
                )
              ],
            )),
      ),
    );
  }
}

List<String> tujuanList = [
  "untuk daur ulang sampah",
  "melaporkan tumpukan sampah",
  "melaporkan pelanggaran sampah",
  "mengikuti misi lingkungan",
  "terhubung dengan komunitas"
];
