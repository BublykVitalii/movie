import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/movie_favorite_screen/domain/account_service.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Favorite Movie';

class FavoriteScreen extends StatefulWidget {
  static const _routeName = '/favorite-screen';

  static PageRoute<FavoriteScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const FavoriteScreen();
      },
    );
  }

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
  AccountService get accountService => GetIt.instance.get<AccountService>();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return const MovieCard();
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  AccountService get accountService => GetIt.instance.get<AccountService>();
  const MovieCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 60,
        color: Colors.green,
      ),
      title: const Text('title movie'),
      trailing: SizedBox(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: AppColors.darkBlue,
          ),
        ),
      ),
    );
  }
}
