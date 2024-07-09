import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';
import 'package:recything_mobile/screens/recy/widget/recy_chat.dart';
import 'package:recything_mobile/screens/recy/widget/user_chat.dart';
import 'package:recything_mobile/widgets/forms/custom_back_button.dart';

import '../../../bloc/recyBot/post_recy_bot_cubit.dart';

class RecyAiScreen extends StatefulWidget {
  const RecyAiScreen({super.key});

  @override
  State<RecyAiScreen> createState() => _RecyAiScreenState();
}

class _RecyAiScreenState extends State<RecyAiScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController aiEcd = TextEditingController();
    String status = " Online";
    bool enableTyping = true;

    void reset() {
      aiEcd.clear();
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Pallete.textMainButton,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: CustomBackButton(),
          ),
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Pallete.main,
              child: Image.asset(
                "assets/icons/profile/mbarecy.png",
                width: 24,
                color: Pallete.textMainButton,
              ),
            ),
            title: Text(
              "Recy",
              style: ThemeFont.heading6Medium,
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Pallete.main),
                ),
                BlocBuilder<PostRecyBotCubit, PostRecyBotState>(
                  builder: (context, state) {
                    if (state is PostRecyBotLoading) {
                      status = " Mengetik . . . .";
                    } else {
                      status = " Online";
                    }
                    return Text(
                      status,
                      style: ThemeFont.bodySmallRegular
                          .copyWith(color: Pallete.main),
                    );
                  },
                )
              ],
            ),
          )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              RecyChat(
                text: "Halo! Saya Recy. Bagaimana Saya bisa membantu Anda?",
                time:
                    "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}",
              ),
              BlocListener<PostRecyBotCubit, PostRecyBotState>(
                listener: (context, state) {},
                child: Builder(
                  builder: (BuildContext context) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: context
                          .watch<PostRecyBotCubit>()
                          .QuestionAnswerList
                          .length,
                      itemBuilder: (context, index) {
                        var item = context
                            .watch<PostRecyBotCubit>()
                            .QuestionAnswerList[index];

                        return Column(
                          children: [
                            UserChat(
                              text: item["question"] ?? "",
                              time: item["time"] ?? "",
                            ),
                            RecyChat(
                              text: item["answer"] ?? "",
                              time: item["time"] ?? "",
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              child: BlocBuilder<PostRecyBotCubit, PostRecyBotState>(
                builder: (context, state) {
                  if (state is PostRecyBotLoading) {
                    enableTyping = false;
                  } else {
                    enableTyping = true;
                  }
                  return TextFormField(
                    enabled: enableTyping,
                    controller: aiEcd,
                    decoration: InputDecoration(
                      hintText: 'Tuliskan disini',
                      hintStyle: ThemeFont.bodySmallMedium
                          .copyWith(color: Pallete.dark3),
                      filled: true,
                      fillColor: Pallete.light2,
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.main,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: BlocBuilder<PostRecyBotCubit, PostRecyBotState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        if (state is! PostRecyBotLoading) {
                          context
                              .read<PostRecyBotCubit>()
                              .postQuestion(aiEcd.text);
                          reset();
                        }
                      },
                      icon: const Icon(
                        IconlyLight.send,
                        color: Pallete.main,
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
