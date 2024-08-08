import 'package:application/features/authentication/screen/onboarding/login/user_controller.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';
import 'TShimmer.dart';
import 'appbar.dart';
import 'cart_menuicon.dart';
import 'package:get/get.dart';
class THomeAppbar extends StatelessWidget {
  const THomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TText.appbartitle,
            style: Theme.of(context).textTheme.labelMedium?.apply(color: TColors.darkgrey),
          ),
          Obx((){ if(controller.profileLoading.value){
            return const TShimmerEffect(width: 80, height:15,);
          } else{
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
            );
          }

  }),
        ],
      ),
      actions: [
        TCartContainer(onPressed: (){},iconColor: TColors.white,)


      ],
    );
  }
}
