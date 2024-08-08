import 'package:application/features/shop/screen/custom%20widgets/circular_icon.dart';
import 'package:application/utils/constants/Textsize.dart';
import 'package:application/utils/helpers/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
class TBottomAddtoCart extends StatelessWidget {
  const TBottomAddtoCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TextSizes.defaultSpace, vertical: TextSizes.defaultSpace/2),
      decoration: BoxDecoration(
        color: dark?TColors.dark : TColors.light,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(TextSizes.cardradiuslg),
          topRight: Radius.circular(TextSizes.cardradiuslg),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(icon: Iconsax.minus,
              backgroundColor: TColors.darkgrey,
              width: 40,
              height: 40,
              color: TColors.white,),
              const SizedBox(width: TextSizes.spaceBtwItems,),
              Text("2",style:Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: TextSizes.spaceBtwItems,),
             TCircularIcon(icon:Iconsax.add,
               backgroundColor: TColors.darkgrey,
               width: 40,
               height: 40,
               color: TColors.white,
             )
            ],
          ),
          ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(padding: EdgeInsets.all(TextSizes.md),backgroundColor: Colors.pinkAccent,
    side:BorderSide(color: Colors.pinkAccent)),child: Text("Add to Cart",style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
