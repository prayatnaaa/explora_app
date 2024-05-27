import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/transactions/member_transaction_input.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionList extends StatefulWidget {
  final int id;
  const TransactionList({required this.id, super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionBloc(transactionDatasource: TransactionDatasource())
            ..add(MemberTransaction(id: widget.id)),
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, transactionState) {
          if (transactionState is TransactionInitial ||
              transactionState is TransactionAdded) {
            BlocProvider.of<TransactionBloc>(context)
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
                    CoolButton(
                        text: "Add Transaction",
                        color: themeColor,
                        onTap: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController memberIdController =
                                      TextEditingController();
                                  TextEditingController
                                      transactionIdController =
                                      TextEditingController();
                                  TextEditingController amountController =
                                      TextEditingController();
                                  return TransactionInput(
                                      hintText: "",
                                      memberIdController: memberIdController,
                                      transactionIdController:
                                          transactionIdController,
                                      amountController: amountController,
                                      onTap: () {
                                        TransactionBloc(
                                                transactionDatasource:
                                                    TransactionDatasource())
                                            .add(AddTransaction(
                                                memberId: widget.id,
                                                transactionId: int.tryParse(
                                                        transactionIdController
                                                            .text) ??
                                                    0,
                                                amount: int.tryParse(
                                                        amountController
                                                            .text) ??
                                                    0));

                                        Navigator.pop(context);
                                      });
                                });
                          });
                        }),
                    MyText(
                        child: savings.saldo.toString(),
                        fontSize: 16,
                        color: themeColor,
                        fontWeight: FontWeight.bold),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: transactions[index].type == 3
                                  ? Colors.red
                                  : themeColor),
                          child: Column(
                            children: [
                              MyText(
                                child: transactions[index].id.toString(),
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal,
                              ),
                              MyText(
                                child: transactions[index].amount.toString(),
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal,
                              ),
                              MyText(
                                child: transactions[index].date.toString(),
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal,
                              ),
                              MyText(
                                child: transactions[index].type.toString(),
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
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
          return const Text("test");
        },
      ),
    );
  }
}
