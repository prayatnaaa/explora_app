import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/loading_screen.dart';
import 'package:explora_app/components/my_snackbar.dart';
import 'package:explora_app/components/null_data.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionsContainer extends StatefulWidget {
  final int id;
  final int? isActive;
  const TransactionsContainer(
      {super.key, required this.id, required this.isActive});

  @override
  State<TransactionsContainer> createState() => _TransactionsContainerState();
}

class _TransactionsContainerState extends State<TransactionsContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionAdded) {
          showCustomSnackBar(context, "Transaction added!",
              color: Colors.green, contentColor: white);
          Navigator.pop(context);
          if (state is TransactionError) {
            showCustomSnackBar(context, "Invalid data!",
                color: Colors.red, contentColor: white);
          }
        }
        // TODO: implement listener
      },
      child: BlocBuilder(
          bloc: BlocProvider.of<TransactionBloc>(context)
            ..add(MemberTransaction(id: widget.id)),
          builder: (context, state) {
            if (state is TransactionInitial || state is TransactionAdded) {
              BlocProvider.of<TransactionBloc>(context)
                  .add(MemberTransaction(id: widget.id));
            }
            if (state is TransactionLoading) {
              return const LoadingScreen();
            } else if (state is TransactionLoaded) {
              final transactions = state.transactions;
              final savings = state.savings;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _savingsContainer(context,
                      savings: savings,
                      memberId: widget.id,
                      isActive: widget.isActive),
                  const SizedBox(
                    height: 48,
                  ),
                  MyText(
                      child: "Transactions History",
                      fontSize: 16,
                      color: black,
                      fontWeight: FontWeight.bold),
                  Flexible(
                      child: _transactionsContainer(transactions: transactions))
                ],
              );
            } else if (state is TransactionError) {
              final message = state.error;
              return Center(
                child: MyText(
                    child: message.toString(),
                    fontSize: 12,
                    color: black,
                    fontWeight: FontWeight.normal),
              );
            }
            return const LoadingScreen();
          }),
    );
  }
}

String currencyFormatter(int number) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: "");
  String formattedNumber = formatter.format(number);

  return formattedNumber;
}

Widget _savingsContainer(BuildContext context,
    {required int savings, required int memberId, required int? isActive}) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
        color: themeColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  child: "SAVINGS",
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600),
              _addTransactionButton(context,
                  memberId: memberId, isActive: isActive, savings: savings)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  child: "RP",
                  fontSize: 12,
                  color: white,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                width: 5,
              ),
              MyText(
                  child: currencyFormatter(savings),
                  fontSize: 24,
                  color: white,
                  fontWeight: FontWeight.bold),
            ],
          )
        ],
      ),
    ),
  );
}

String transactionType(int transactionType) {
  String type = "";

  switch (transactionType) {
    case 1:
      type = "First Transaction";
      break;

    case 2:
      type = "Add Savings";
      break;

    case 3:
      type = "Withdraw";
      break;
    case 5:
      type = "Adjustment Addition";
      break;

    case 6:
      type = "Adjustment Deduction";
      break;
  }
  return type;
}

String validationTransaction(String transaction, int type) {
  if (type == 3 || type == 6) {
    return "-Rp $transaction";
  }
  return "Rp $transaction";
}

Widget _transactionsContainer({required List transactions}) {
  if (transactions.isEmpty) {
    return const NullData();
  }

  transactions.sort((a, b) => b.date.compareTo(a.date));
  return ListView.builder(
    itemCount: 2,
    itemBuilder: (context, index) {
      final transaction = transactions[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _helperContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      child: transactionType(transaction.type),
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.bold),
                  MyText(
                      child: "ID${transaction.id}",
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.w500),
                  MyText(
                      child: transaction.date.toString(),
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.w500)
                ],
              ),
              MyText(
                  child: validationTransaction(
                      currencyFormatter(transaction.amount), transaction.type),
                  fontSize: 16,
                  color: transaction.type == 3 || transaction.type == 6
                      ? Colors.red
                      : themeColor,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
      );
    },
  );
}

Widget _addTransaction(BuildContext context,
    {required int memberId, required int? isActive, required int savings}) {
  List<TransactionType> transactionTypes = TransactionType.transactionsType;
  final TextEditingController amountController = TextEditingController();

  return CircleAvatar(
      backgroundColor: isActive == 1 ? white : grey,
      child: IconButton(
          onPressed: isActive == 1
              ? () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: white,
                      context: context,
                      builder: (ctx) => BlocProvider.value(
                            value: context.read<TransactionBloc>(),
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: MyText(
                                        child: "Add Transactions",
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: transactionTypes
                                        .map((transactionType) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _showAddTransactionDialog(
                                                    context,
                                                    memberId: memberId,
                                                    transctionType:
                                                        transactionType.id,
                                                    controller:
                                                        amountController,
                                                  );
                                                },
                                                child: _helperContainer(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          transactionType.icon),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      MyText(
                                                          child: transactionType
                                                              .type,
                                                          fontSize: 16,
                                                          color: black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ));
                }
              : () {
                  showCustomSnackBar(context,
                      "Member is inactive, cannot add any transactions!",
                      color: Colors.red, contentColor: white);
                },
          icon: Icon(Icons.add, color: themeColor)));
}

Widget _addTransactionButton(BuildContext context,
    {required int memberId, required int? isActive, required int savings}) {
  if (savings == 0) {
    return _addFirstTransaction(context,
        memberId: memberId, isActive: isActive, savings: savings);
  }
  return _addTransaction(context,
      memberId: memberId, isActive: isActive, savings: savings);
}

Widget _addFirstTransaction(BuildContext context,
    {required int memberId, required int? isActive, required int savings}) {
  final TextEditingController amountController = TextEditingController();

  return CircleAvatar(
      backgroundColor: isActive == 1 ? white : grey,
      child: IconButton(
          onPressed: isActive == 1
              ? () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: white,
                      context: context,
                      builder: (ctx) => BlocProvider.value(
                            value: context.read<TransactionBloc>(),
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: MyText(
                                        child: "Add Transactions",
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showAddTransactionDialog(
                                                context,
                                                memberId: memberId,
                                                transctionType: 1,
                                                controller: amountController,
                                              );
                                            },
                                            child: _helperContainer(
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.money),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  MyText(
                                                      child:
                                                          "First Transaction",
                                                      fontSize: 16,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ])
                                ],
                              ),
                            ),
                          ));
                }
              : () {
                  showCustomSnackBar(context,
                      "Member is inactive, cannot add any transactions!",
                      color: Colors.red, contentColor: white);
                },
          icon: Icon(Icons.add, color: themeColor)));
}

Widget _helperContainer({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: black),
        borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ),
  );
}

void _showAddTransactionDialog(BuildContext context,
    {required int transctionType,
    required TextEditingController? controller,
    required int memberId}) {
  String type = "";

  switch (transctionType) {
    case 1:
      type = "First Transaction";
      break;

    case 2:
      type = "Add Savings";
      break;

    case 3:
      type = "Withdraw";
      break;
    case 5:
      type = "Adjustment Addition";
      break;

    case 6:
      type = "Adjustment Deduction";
      break;
  }
  showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
            value: context.read<TransactionBloc>(),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                        child: type,
                        fontSize: 16,
                        color: black,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 36,
                    ),
                    _textfield(controller, "Amount"),
                    const SizedBox(
                      height: 12,
                    ),
                    CoolButton(
                        text: "Add",
                        color: themeColor,
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (ctx) => BlocProvider.value(
                                    value: context.read<TransactionBloc>(),
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      backgroundColor: white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            MyText(
                                                child: "Confirmation",
                                                fontSize: 16,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                            const SizedBox(
                                              height: 36,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MyText(
                                                    child: type,
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                MyText(
                                                    child:
                                                        "Rp${controller!.text}",
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            CoolButton(
                                                fillColor: themeColor,
                                                textColor: white,
                                                text: "Confirm",
                                                color: themeColor,
                                                onTap: () {
                                                  BlocProvider.of<TransactionBloc>(
                                                          context)
                                                      .add(AddTransaction(
                                                          memberId: memberId,
                                                          transactionId:
                                                              transctionType,
                                                          amount: int.tryParse(
                                                                  controller
                                                                      .text) ??
                                                              0));
                                                  Navigator.pop(context);
                                                }),
                                            _cancelButton(context),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        }),
                    _clearControllerOnCancel(context, controller: controller)
                  ],
                ),
              ),
            ),
          ));
}

Widget _textfield(TextEditingController? controller, String labelText) {
  if (controller!.text.isEmpty) {
    print("cannot");
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: TextField(
        controller: controller,
        cursorColor: themeColor,
        decoration: InputDecoration(
            hintText: currencyFormatter(int.tryParse(controller.text) ?? 0),
            hintStyle: GoogleFonts.poppins(color: white),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(color: black, fontSize: 12),
            hoverColor: Colors.grey,
            fillColor: themeColor,
            prefix: MyText(
                child: "Rp",
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.normal),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            filled: false)),
  );
}

Widget _errorTextfield(TextEditingController? controller, String labelText) {
  if (controller!.text.isEmpty) {
    print("cannot");
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: TextField(
        controller: controller,
        cursorColor: Colors.red,
        decoration: InputDecoration(
            hintText: controller.text,
            hintStyle: GoogleFonts.poppins(color: white),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(color: black, fontSize: 12),
            hoverColor: Colors.grey,
            fillColor: Colors.red,
            prefix: MyText(
                child: "Rp",
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.normal),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            filled: false)),
  );
}

Widget _cancelButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: const Padding(
      padding: EdgeInsets.only(top: 4),
      child: MyText(
          child: "Cancel",
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget _clearControllerOnCancel(BuildContext context,
    {required TextEditingController? controller}) {
  return GestureDetector(
    onTap: () {
      controller!.clear();
      Navigator.pop(context);
    },
    child: const MyText(
        child: "Cancel",
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.bold),
  );
}
