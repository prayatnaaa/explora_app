import 'dart:async';

import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/transactions/member_transaction_input.dart';
import 'package:explora_app/pages/transactions/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final int id;
  const TransactionList({required this.id, super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    String currencyFormatter(int number) {
      final formatter = NumberFormat.currency(locale: 'en_US', symbol: 'Rp');
      String formattedNnumber = formatter.format(number);

      return formattedNnumber;
    }

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, transactionState) {
        if (transactionState is TransactionInitial ||
            transactionState is TransactionAdded) {
          TransactionBloc(transactionDatasource: TransactionDatasource())
              .add(MemberTransaction(id: widget.id));
        } else if (transactionState is TransactionLoaded) {
          final transactions = transactionState.transactions;
          final savings = transactionState.savings;
          return Center(
            child: Container(
              constraints:
                  const BoxConstraints(maxWidth: 500), // Example constraint
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      String transactionType = "";

                      switch (transactions[index].type) {
                        case 1:
                          transactionType = "Saldo Awal";
                          break;

                        case 2:
                          transactionType = "Simpanan";
                          break;
                        case 3:
                          transactionType = "Penarikan";
                          break;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(8),
                              color: white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          child: transactionType,
                                          fontSize: 16,
                                          color: transactions[index].type == 3
                                              ? Colors.red
                                              : Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                              child:
                                                  "ID${transactions[index].id.toString()}",
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            MyText(
                                              child:
                                                  "${transactions[index].date}",
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    MyText(
                                      child: transactions[index].type == 3
                                          ? '-${currencyFormatter(transactions[index].amount)}'
                                          : '+${currencyFormatter(transactions[index].amount)}',
                                      fontSize: 16,
                                      color: transactions[index].type == 3
                                          ? Colors.red
                                          : Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (transactionState is TransactionError) {
          return Center(
            child: Text(transactionState.error),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
