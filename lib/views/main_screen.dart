import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/buyers_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/category_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/orders_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/product_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/subcategory_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/upload_banner_screen.dart';
import 'package:web_app_admin_panel/views/side_bar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();

  screenSelector(item) {
    switch (item.route) {
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;

      case SubcategoryScreen.id:
        setState(() {
          _selectedScreen = SubcategoryScreen();
        });
        break;  
      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;
      case ProductScreen.id:
        setState(() {
          _selectedScreen = ProductScreen();
        });
        break;
      default:
        return VendorsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Management")),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(child: Text("Multi Store Admin", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.7,
          ),),),
        ),
        items: [
          AdminMenuItem(
            title: "Vendors",
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: "Buyer",
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: "Orders",
            route: OrdersScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: "Categories",
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: "Subcategories",
            route: SubcategoryScreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: "Upload Banner",
            route: UploadBannerScreen.id,
            icon: Icons.upload,
          ),
          AdminMenuItem(
            title: "Products",
            route: ProductScreen.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item){
          screenSelector(item);
        },
      ),
    );
  }
}
