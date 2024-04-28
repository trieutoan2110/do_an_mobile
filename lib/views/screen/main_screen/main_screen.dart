import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/views/screen/main_screen/cart_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/home_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/info_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar (
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: StringConstant.home_title),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: StringConstant.cart_title),
          NavigationDestination(icon: Icon(Icons.favorite), label: StringConstant.wishlist_title),
          NavigationDestination(icon: Icon(Icons.account_circle), label: StringConstant.me_title),
        ],
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
      // body: IndexedStack (
      //   index: selectedPageIndex,
      //   children: const [HomeView(), CartView(), WishlistView(), InformationView()],
      // )
      body: const [HomeView(), CartView(), WishlistView(), InformationView()][selectedPageIndex],
    );
  }
}
