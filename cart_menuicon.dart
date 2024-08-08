import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/personalization/screens/cart/cart.dart';
import '../../utils/constants/colors.dart';
import 'package:get/get.dart';
class TCartContainer extends StatelessWidget {
  const TCartContainer({
    super.key, required this.onPressed,  this.iconColor, this.bgColor, this.counterTextColor,
  });
  final VoidCallback onPressed;
  final Color? iconColor,bgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Iconsax.shopping_bag,color: iconColor,),
          onPressed: ()=>Get.to(()=>const CartScreen()),
          // Add search action here

        ),
        Positioned(
          right: 0,
          child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(color: TColors.black,borderRadius: BorderRadius.circular(100)
              ),
              child:Center(
                child: Text("2",style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white,fontSizeFactor: 0.8),),
              )
          ),
        )
      ],
    );
  }
}
