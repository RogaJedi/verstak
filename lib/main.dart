import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:verstak/pages/cart_page.dart';
import 'package:verstak/pages/gifts_page.dart';
import 'package:verstak/pages/home_page.dart';
import 'package:verstak/pages/user/user_page.dart';
import 'package:verstak/pages/user/welcome_page.dart';
import 'package:verstak/models/product.dart';
import 'package:verstak/product_loader/products_cubit.dart';
import 'package:verstak/user_state_management/user_cubit.dart';
import 'package:verstak/user_state_management/user_state.dart';
import 'package:verstak/widgets/custom_bottom_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verstak/widgets/search_bar_related/custom_search_bar.dart';
import 'package:verstak/widgets/search_bar_related/search_bar_state_management.dart';
import 'package:verstak/widgets/search_bar_related/search_results_page.dart';

import 'api_service.dart';
import 'auth/auth_cubit.dart';
import 'loading_screen.dart';
import 'navigation_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw Exception('Err: no SUPABASE_URL or SUPABASE_ANON_KEY');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  final apiService = ApiService();

  runApp(MyApp(apiService: apiService));
}


class MyApp extends StatelessWidget {
  final ApiService apiService;
  const MyApp({
    super.key,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => ProductsCubit(apiService: apiService)),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UserCubit(apiService: apiService, productsCubit: context.read<ProductsCubit>(),),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat'
        ),
        home: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoaded) {
              final products = (context.read<ProductsCubit>().state as ProductsLoaded).products;
              return HubPage(products: products, apiService: apiService,);
            }
            if (state is ProductsError) {
              print(state.message);
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: Colors.red),
                      const SizedBox(height: 20),
                      Text('Ошибка: ${state.message}'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProductsCubit>().loadProducts();
                        },
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const LoadingScreen();
          },
        ),
      ),
    );
  }
}


class HubPage extends StatefulWidget {
  final ApiService apiService;
  final List<Product> products;

  const HubPage({
    Key? key,
    required this.apiService,
    required this.products,
  }) : super(key: key);

  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  late SearchCubit _searchCubit;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(allProducts: widget.products);
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchCubit,
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return BlocBuilder<AuthCubit, AppAuthState>(
            builder: (context, authState) {
              return BlocBuilder<SearchCubit, SearchState>(
                builder: (context, searchState) {
                  final List<Widget> pages = [
                    HomePage(apiService: widget.apiService, products: widget.products),
                    GiftsPage(apiService: widget.apiService, products: widget.products),
                    CartPage(apiService: widget.apiService, allProducts: widget.products),
                    authState is AuthAuthenticated
                        ? UserPage()
                        : WelcomePage(apiService: widget.apiService, products: widget.products),
                  ];

                  // Определяем, что показывать в body
                  Widget body;
                  if (searchState is SearchResults) {
                    body = SearchResultsPage(
                      searchResults: searchState.results,
                      searchQuery: searchState.query, apiService: widget.apiService,
                    );
                  } else {
                    body = pages[currentIndex];
                  }

                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xFF187A3F),
                      elevation: 0,
                      title: CustomSearchBar(
                        readOnly: !_isSearching,
                        onTap: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        onSearch: (query) {
                          _searchCubit.search(query);
                        },
                      ),
                      leading: searchState is! SearchInitial || _isSearching
                          ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                          });
                          _searchCubit.clearSearch();
                        },
                      )
                          : null,
                    ),
                    body: body,
                    bottomNavigationBar: searchState is SearchInitial
                        ? CustomBottomBar(
                      activeIcons: [
                        'assets/home_filled.svg',
                        'assets/gift_filled.svg',
                        'assets/cart_filled.svg',
                        'assets/user_filled.svg',
                      ],
                      inactiveIcons: [
                        'assets/home_empty.svg',
                        'assets/gift_empty.svg',
                        'assets/cart_empty.svg',
                        'assets/user_empty.svg',
                      ],
                      onTap: (index) {
                        context.read<NavigationCubit>().setPage(index);
                      },
                      backgroundColor: const Color(0xFF187A3F),
                    )
                        : null,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}            
    