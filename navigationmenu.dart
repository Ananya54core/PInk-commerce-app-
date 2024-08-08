import 'package:application/features/shop/screen/home.dart';
import 'package:application/features/shop/screen/settings.dart';
import 'package:application/utils/constants/colors.dart';
import 'package:application/utils/helpers/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'features/shop/screen/store.dart';
import 'features/shop/screen/whishlist.dart';
class Navigationmenu extends StatelessWidget {
  const Navigationmenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkmode =THelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
          ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value= index,
          backgroundColor: darkmode? TColors.black:TColors.white,
          indicatorColor: darkmode?TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
        
          destinations:const [
             NavigationDestination(icon:Icon(Iconsax.home), label:'Home'),
             NavigationDestination(icon:Icon(Iconsax.shop), label:'Store'),
             NavigationDestination(icon:Icon(Iconsax.heart), label:'Whishist'),
             NavigationDestination(icon:Icon(Iconsax.user), label:'User'),
        
        
          ]
        ),
      ),
      body:Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}
class NavigationController extends GetxController{
  final Rx<int> selectedIndex =0.obs;
  final screens =[const HomeScreen(),const Store(),const FavouriteScreen(),const SettingScreen(),];
}
