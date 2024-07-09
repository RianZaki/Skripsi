import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:recything_mobile/constants/pallete.dart';

import '../../bloc/recyBot/post_recy_bot_cubit.dart';


class CustomBackButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Pallete.light3,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          } else {
            Navigator.of(context).pop();
            context.read<PostRecyBotCubit>().clearQuestionAnswerList();
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            IconlyLight.arrow_left,
            size: 24.0,
            color: Pallete.dark1,
          ),
        ),
      ),
    );
  }
}
