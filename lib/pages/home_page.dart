import 'package:crypto_app_using_rest_api/models/crypto_listing_model.dart';
import 'package:crypto_app_using_rest_api/repositories/crypto_listing_repository.dart';
import 'package:crypto_app_using_rest_api/themes/colors.dart';
import 'package:flutter/material.dart';
import '../components/crypto_list_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CryptoListingModel>> cryptoListingFuture;

  @override
  void initState() {
    cryptoListingFuture = CryptoListingRepository.all();
    super.initState();
  }

  void refreshData() {
    setState(() {
      cryptoListingFuture = CryptoListingRepository.all();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.scaffoldBackgroundColor,
        appBar: appBar(),
        body: body(),
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: ThemeColors.cardBackgroundColor,
        leading: IconButton(
          onPressed: refreshData,
          icon: const Icon(Icons.refresh),
        ),
        title: const Text(
          'CRYPTO',
          style: TextStyle(
            letterSpacing: 5,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('images/foto.jpg'),
              ))
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Il mio saldo:',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '€ 34.500,00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget body() => Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: ThemeColors.cardBackgroundColor,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, -2),
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ]),
        child: Column(
          children: [
            bodyHeader(),
            const Divider(),
            bodyContent(),
          ],
        ),
      );

  Widget bodyHeader() => const ListTile(
        title: Text(
          'Elenco Crypto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Top 100'),
        trailing: Text('Valore Attuale'),
      );

  Widget bodyContent() => Expanded(
        child: FutureBuilder<List<CryptoListingModel>>(
            future: cryptoListingFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                  itemBuilder: (context, index) => CryptoListTile(
                    symbol: snapshot.data![index].symbol,
                    name: snapshot.data![index].name,
                    price: snapshot.data![index].price,
                    variation24h: snapshot.data![index].percentChange24h,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}
