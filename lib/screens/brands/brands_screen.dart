import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sticky_headers/sticky_headers.dart';

import '../../common/constants.dart';
import '../../generated/l10n.dart';
import '../../routes/flux_navigate.dart';
import '../../services/service_config.dart';
import '../brand/model/brand_model.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  List<String> allBrandsList = [];
  List<String> brandsList = [];
  List<String> firstLetters = [];
  bool _isLoading = false;

  final TextEditingController filterController = TextEditingController();

  void onFilter(String? value) {
    if (value != null) {
      brandsList = allBrandsList
          .where(
              (element) => element.toLowerCase().contains(value.toLowerCase()))
          .toList();
      firstLetters.clear();
      for (var e in brandsList) {
        var firstLetter = e.toString()[0];
        if (!firstLetters.contains(firstLetter)) {
          firstLetters.add(firstLetter);
        }
      }
      setState(() {});
    }
  }

  Future<void> getAllBrands() async {
    if (mounted) {
      try {
        _isLoading = true;
        brandsList.clear();
        setState(() {});

        // TODO(fahjan): remove this after activate kaif.co
        var serverUrl = ServerConfig().url;

        var url = '$serverUrl/pages/vendors'.toUri()!;

        var response = await http.get(url);

        List data = jsonDecode(response.body);

        for (var e in data) {
          var firstLetter = e.toString()[0];
          if (!firstLetters.contains(firstLetter)) {
            firstLetters.add(firstLetter);
          }
          brandsList.add(e.toString());
          MyBrandModel.fromShopifyJson(e);
        }

        allBrandsList = brandsList;
        _isLoading = false;

        setState(() {});
      } catch (e) {
        _isLoading = false;
      }
    }
  }

  void gotoSearch(var keyword) {
    FluxNavigate.pushNamed(RouteList.search, arguments: {
      'keyword': keyword,
      'isFromBrands': true,
    });
  }

  @override
  void initState() {
    getAllBrands();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            S.of(context).allBrands,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            // color: Colors.white,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
            height: 48.0,
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Form(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  // textAlign: TextAlign.center,
                  controller: filterController,
                  onChanged: (value) {
                    onFilter(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: getAllBrands,
        child: Visibility(
          visible: !_isLoading,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: firstLetters.length,
            itemBuilder: (context, index) {
              var letter = firstLetters[index];
              var letterBrandsList =
                  brandsList.where((element) => element[0] == letter).toList();
              return StickyHeader(
                header: Container(
                  height: 50.0,
                  color: const Color(0xff0e203d),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                content: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var brand = letterBrandsList[index];
                    return ListTile(
                      dense: true,
                      // splashColor: Colors.white,
                      title: Center(
                        child: Text(
                          brand,
                        ),
                      ),
                      onTap: () => gotoSearch(brand),
                      // trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                  itemCount: letterBrandsList.length,
                ),
              );
            },
          ),
        ),
      ),
      // AzListView(data: data, itemBuilder: (BuildContext context, int index) { return ListTile(title: Text(index.toString()),); }, itemCount: 5,),

      /* ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text('1'),
        ),
      ), */
    );
  }
}
