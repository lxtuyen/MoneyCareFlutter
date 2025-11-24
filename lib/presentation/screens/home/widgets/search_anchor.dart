import 'package:flutter/material.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/models/transaction_model.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_item.dart';

class SearchAnchorCustom extends StatefulWidget {
  const SearchAnchorCustom({super.key, required this.listData});

  final List<TransactionModel> listData;

  @override
  State<SearchAnchorCustom> createState() => _SearchAnchorCustomState();
}

class _SearchAnchorCustomState extends State<SearchAnchorCustom> {
  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SearchAnchor.bar(
        barHintText: 'Enter transaction name',
        viewHintText: 'Search transactions',
        searchController: _searchController,
        suggestionsBuilder: (context, controller) {
          final query = controller.text.toLowerCase();

          final filtered = widget.listData.where((item) {
            return query.isEmpty ||
                (item.note?.toLowerCase().contains(query) ?? false);
          }).toList();

          if (filtered.isEmpty) {
            return [
              SizedBox(
                height: 100,
                child: Center(child: Text('No transactions found')),
              ),
            ];
          }

          final List<Widget> widgets = filtered.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TransactionItem(
                item: item,
                onTap: () {},
                color: AppHelperFunction.getRandomColor(),
              ),
            );
          }).toList();

          return [
            Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: widgets,
              ),
            ),
          ];
        },
      ),
    );
  }
}
