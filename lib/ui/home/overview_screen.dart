import 'package:dengue_zero/ui/home/widgets/drawer_item.dart';
import 'package:dengue_zero/utils/app_routes.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            'assets/images/Z.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      drawer: const DrawerItem(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá, Cidadão',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: deviceSize.height * 0.05),
            Text(
              'AJUDE A COMBATER A DENGUE',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: deviceSize.height * 0.15),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.NEW_COMPLAINT_SCREEN);
              },
              child: const Text('NOVA DENÚNCIA'),
            ),
            SizedBox(height: deviceSize.height * 0.05),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.MY_COMPLAINTS_SCREEN);
              },
              child: const Text('MINHAS DENÚNCIAS'),
            ),
          ],
        ),
      ),
    );
  }
}
