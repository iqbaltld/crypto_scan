import 'package:crypto_scan/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          String title = state.maybeMap(
            success: (_state) =>
                _state.tabIndex == 0 ? "Crypto Currencies" : "Favourites",
            orElse: () => "Crypto Currencies",
          );
          return Text(title);
        },
      ),
    ), body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.maybeMap(
            initial: (_) {
              context.read<HomeBloc>().add(const HomeEvent.started());
              return const Center(child: CircularProgressIndicator());
            },
            success: (_state) {
              return IndexedStack(
                index: _state.tabIndex,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          onChanged: (value) => context
                              .read<HomeBloc>()
                              .add(HomeEvent.searchChanged(value)),
                          decoration: const InputDecoration(
                            labelText: "Search",
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _state.filteredCurrencies.take(25).length,
                          itemBuilder: (context, index) {
                            final item = _state.filteredCurrencies[index];
                            return ListTile(
                              title: Text(item.baseAsset!),
                              trailing: IconButton(
                                icon: Icon(
                                    _state.favoriteCurrencies.contains(item)
                                        ? Icons.star
                                        : Icons.star_border),
                                onPressed: () => context.read<HomeBloc>().add(
                                    HomeEvent.toggleFavorite(item.symbol!)),
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, '/trends',
                                  arguments: item.symbol),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: _state.favoriteCurrencies.length,
                    itemBuilder: (context, index) {
                      final item = _state.favoriteCurrencies[index];
                      return ListTile(
                        title: Text(item.baseAsset!),
                        onTap: () => Navigator.pushNamed(context, '/trends',
                            arguments: item.symbol),
                      );
                    },
                  ),
                ],
              );
            },
            error: (_error) => Center(child: Text(_error.error ?? '')),
            orElse: () => const Center(child: CircularProgressIndicator()));
      },
    ), bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int index = state.maybeMap(
            success: (_state) => _state.tabIndex, orElse: () => 0);
        return BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                context.read<HomeBloc>().add(const HomeEvent.tabChanged(0));
                break;
              case 1:
                context.read<HomeBloc>().add(const HomeEvent.tabChanged(1));
                break;
            }
          },
        );
      },
    ));
  }
}
