import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/domain/repository/di.dart' show container;
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';
import 'package:shopengo/feature/home/domain/cubit/home_bloc.dart';
import 'package:shopengo/feature/home/domain/cubit/home_event.dart';
import 'package:shopengo/feature/home/domain/cubit/home_state.dart';
import 'package:shopengo/feature/home/presentation/widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const path = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(container.resolve<StoreRepositoryImpl>())..add(LoadStoresEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeStoresReadyState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      HomeAppBar(totalStores: state.stores.length),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
