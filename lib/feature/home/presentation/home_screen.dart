import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/domain/repository/di.dart' show container;
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';
import 'package:shopengo/feature/home/domain/cubit/home_bloc.dart';
import 'package:shopengo/feature/home/domain/cubit/home_event.dart';
import 'package:shopengo/feature/home/domain/cubit/home_state.dart';
import 'package:shopengo/feature/home/presentation/widgets/home_app_bar.dart';
import 'package:shopengo/feature/home/presentation/widgets/home_text_field.dart';
import 'package:shopengo/feature/home/presentation/widgets/store_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const path = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(container.resolve<StoreRepositoryImpl>())..add(LoadStoresEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeCreatingStoreState) {
              _homeTextFieldController.clear();
            }
          },
          builder: (context, state) {
            if (state is HomeStoresReadyState || state is HomeCreatingStoreState || state is HomeSearchingStoresState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      HomeAppBar(
                        totalStores: state.stores.length,
                        isCreating: state is HomeCreatingStoreState,
                        isSearching: state is HomeSearchingStoresState,
                        onAddPressed: () => context.read<HomeBloc>().add(HomeCreatingStoreEvent()),
                        onSearchPressed: () => context.read<HomeBloc>().add(HomeQueryStoresEvent(query: null)),
                        onCancel: () => _onCancel(context),
                        onCreateStore: () => _onCreateStore(context),
                      ),
                      const SizedBox(height: 12),
                      HomeTextField(
                        isVisible: state is HomeCreatingStoreState || state is HomeSearchingStoresState,
                        onDone: () {},
                        controller: _homeTextFieldController,
                        onChanged: (value) {
                          context.read<HomeBloc>().add(HomeQueryStoresEvent(query: value));
                        },
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.stores.length,
                          itemBuilder: (context, index) {
                            final store = state.stores[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: StoreCard(store: store),
                            );
                          },
                        ),
                      ),
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

  void _onCancel(BuildContext context) {
    _onFieldCollapse();
    context.read<HomeBloc>().add(LoadStoresEvent());
  }

  void _onCreateStore(BuildContext context) {
    context.read<HomeBloc>().add(HomeSubmitNewStoreEvent(storeName: _homeTextFieldController.text));
    _onFieldCollapse();
  }

  void _onFieldCollapse() {
    _homeTextFieldController.clear();
    FocusScope.of(context).unfocus();
  }
}
