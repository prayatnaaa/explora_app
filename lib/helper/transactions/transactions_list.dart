import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/transactions/member_transaction_input.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            child: 'Savings: IDR\t${savings.saldo.toString()}',
                            fontSize: 24,
                            color: themeColor,
                            fontWeight: FontWeight.w600),
                        CoolButton(
                            textColor: white,
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
                                          memberIdController:
                                              memberIdController,
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

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Transaction added successfully!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );

                                            TransactionBloc(
                                                    transactionDatasource:
                                                        TransactionDatasource())
                                                .add(MemberTransaction(
                                                    id: widget.id));
                                          });
                                    });
                              });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: transactions[index].type == 3
                                  ? Colors.red
                                  : themeColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: MyText(
                                    child: transactionType,
                                    fontSize: 20,
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyText(
                                  child:
                                      "ID\t\t\t\t\t\t\t\t\t\t\t\t\t: ${transactions[index].id.toString()}",
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.normal,
                                ),
                                MyText(
                                  child:
                                      "Amount\t\t: IDR${transactions[index].amount.toString()}",
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.normal,
                                ),
                                MyText(
                                  child:
                                      "Date\t\t\t\t\t\t\t\t: ${transactions[index].date.toString()}",
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
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
      ),
    );
  }
}
