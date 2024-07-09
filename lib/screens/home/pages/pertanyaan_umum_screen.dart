import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/bloc/get_all_faq/get_all_faq_cubit.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/article/theme/color_style.dart';
import 'package:recything_mobile/screens/article/theme/text_style.dart';
import 'package:recything_mobile/screens/home/widgets/pertanyaan_card.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';

class PertanyaanUmumScren extends StatefulWidget {
  const PertanyaanUmumScren({super.key});

  @override
  State<PertanyaanUmumScren> createState() => _PertanyaanUmumScrenState();
}

class _PertanyaanUmumScrenState extends State<PertanyaanUmumScren> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<GetAllFaqCubit>().fetchFaq();
  }

  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.textMainButton,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          "Pertanyaan Umum",
          style: ThemeFont.heading6Medium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ThemeColor().dark3Color,
                  width: 1,
                ),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(IconlyLight.search),
                    hintText: "Cari pertanyaan...",
                    hintStyle: ThemeText().bodySmallMedium,
                    border: InputBorder.none),
              ),
            ),
            BlocBuilder<GetAllFaqCubit, GetAllFaqState>(
                builder: (context, state) {
              if (state is GetAllFaqLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetAllFaqFailure) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is GetAllFaqSuccess) {
                final data = state.data
                    .where((element) =>
                        (element.title
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) ||
                        (element.desc
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())))
                    .toList();
                return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) => PertanyaanCard(
                          item: data[index],
                        )));
              }
              return const SizedBox();
            }),
            // )
          ],
        ),
      ),
    );
  }
}
