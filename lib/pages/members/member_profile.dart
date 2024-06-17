import 'package:explora_app/helper/transactions/add_transaction_dialog.dart';
import 'package:explora_app/helper/transactions/transactions_list.dart';
import 'package:explora_app/pages/transactions/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/bloc/transactions_bloc/transaction_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/member_button.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:intl/intl.dart';

class MemberProfile extends StatefulWidget {
  final int index;
  const MemberProfile({super.key, required this.index});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  final MemberBloc memberBloc =
      MemberBloc(remoteDataSource: RemoteDataSource());
  final TransactionBloc transactionBloc =
      TransactionBloc(transactionDatasource: TransactionDatasource());
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final idNumController = TextEditingController();
  final phoneNumController = TextEditingController();

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    String currencyFormatter(int number) {
      final formatter = NumberFormat.currency(locale: 'en_US', symbol: 'Rp');
      String formattedNnumber = formatter.format(number);

      return formattedNnumber;
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: MyText(
            child: "Member Profile",
            fontSize: 16,
            color: black,
            fontWeight: FontWeight.bold),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => memberBloc..add(LoadMember()),
                  ),
                  BlocProvider(
                    create: (context) => transactionBloc,
                  ),
                ],
                child: BlocBuilder<MemberBloc, MemberState>(
                  builder: (context, memberState) {
                    if (memberState is MemberInitial ||
                        memberState is MemberAdded ||
                        memberState is MemberDeleted ||
                        memberState is MemberEdited) {
                      BlocProvider.of<MemberBloc>(context).add(LoadMember());
                    } else if (memberState is MemberLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: themeColor,
                        ),
                      );
                    } else if (memberState is MemberLoaded) {
                      final members = memberState.members;
                      final member = members[widget.index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            member.nama,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: themeColor,
                                            ),
                                          ),
                                          MyText(
                                              child: member.telepon,
                                              fontSize: 16,
                                              color: themeColor,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                      IconButton(
                                          color: themeColor,
                                          onPressed: () {
                                            setState(() {
                                              selected = !selected;
                                            });
                                          },
                                          icon: Icon(selected
                                              ? Icons.visibility
                                              : Icons.visibility_off))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Visibility(
                                    visible: selected,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                                child: "ID",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                            MyText(
                                                child: "${member.id}",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                                child: "Card ID",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                            MyText(
                                                child: "${member.nomor_induk}",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                                child: "Address",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                            MyText(
                                                child: member.alamat,
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                                child: "Birth Date",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                            MyText(
                                                child: member.tgl_lahir,
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CoolButton(
                                                textColor: white,
                                                text: "Edit / Delete",
                                                color: themeColor,
                                                onTap: () {
                                                  _showEditDeleteDialog(member);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: themeColor,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocProvider(
                            create: (context) => transactionBloc
                              ..add(MemberTransaction(id: member.id)),
                            child:
                                BlocListener<TransactionBloc, TransactionState>(
                              listener: (context, state) {
                                if (state is TransactionAdded) {}
                                // TODO: implement listener
                              },
                              child: BlocBuilder<TransactionBloc,
                                  TransactionState>(
                                builder: (context, state) {
                                  if (state is TransactionLoading) {
                                    return const CircularProgressIndicator();
                                  } else if (state is TransactionAdded ||
                                      state is TransactionInitial) {
                                    context
                                        .read<TransactionBloc>()
                                        .add(MemberTransaction(id: member.id));
                                  }
                                  if (state is TransactionLoaded) {
                                    final saving = state.savings.saldo;
                                    final transactions = state.transactions;
                                    TextEditingController amountController =
                                        TextEditingController();
                                    return Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              BlocProvider<
                                                                  TransactionBloc>.value(
                                                                value: context.read<
                                                                    TransactionBloc>(),
                                                                child:
                                                                    AddTransactionDialog(
                                                                        amountController:
                                                                            amountController,
                                                                        onTap:
                                                                            () {
                                                                          context.read<TransactionBloc>().add(AddTransaction(
                                                                              memberId: member.id,
                                                                              transactionId: transactions.isEmpty ? 1 : 2,
                                                                              amount: int.tryParse(amountController.text) ?? 0));
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ));
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .account_balance_outlined,
                                                      color: themeColor,
                                                    )),
                                                MyText(
                                                    child: "Deposit",
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight: FontWeight.w600)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              BlocProvider<
                                                                  TransactionBloc>.value(
                                                                value: context.read<
                                                                    TransactionBloc>(),
                                                                child:
                                                                    AddTransactionDialog(
                                                                        amountController:
                                                                            amountController,
                                                                        onTap:
                                                                            () {
                                                                          context.read<TransactionBloc>().add(AddTransaction(
                                                                              memberId: member.id,
                                                                              transactionId: 3,
                                                                              amount: int.tryParse(amountController.text) ?? 0));
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ));
                                                    },
                                                    icon: Icon(
                                                      Icons.payments,
                                                      color: themeColor,
                                                    )),
                                                MyText(
                                                    child: "Withdraw",
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight: FontWeight.w600)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Row(
                                          children: [
                                            MyText(
                                                child: "Transactions history..",
                                                fontSize: 14,
                                                color: black,
                                                fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                      ),
                                      TransactionList(id: member.id)
                                    ]);
                                  }
                                  return Container(
                                    child: const Center(
                                      child: Text("error bro"),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (memberState is MemberError) {
                      return Center(
                        child: Text(memberState.error),
                      );
                    }
                    return const SizedBox(
                      child: Text("Failed"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDeleteDialog(Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: Border.all(color: themeColor),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: MyText(
                    child: "What do you want?",
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CoolButton(
                      text: 'Edit',
                      textColor: white,
                      color: Colors.yellow,
                      onTap: () {
                        _prepareForEditing(member);
                        _showEditDialog(member);
                      },
                    ),
                    const SizedBox(width: 10),
                    CoolButton(
                      text: "Delete",
                      textColor: white,
                      color: Colors.red,
                      onTap: () {
                        memberBloc.add(DeleteMember(id: member.id));
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _prepareForEditing(Member member) {
    setState(() {
      addressController.text = member.alamat;
      nameController.text = member.nama;
      phoneNumController.text = member.telepon;
      idNumController.text = member.nomor_induk.toString();
      birthDateController.text = member.tgl_lahir;
    });
  }

  void _showEditDialog(Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MemberButton(
          title: "Edit",
          addressController: addressController,
          nameController: nameController,
          phoneNumController: phoneNumController,
          idNumController: idNumController,
          birthDateController: birthDateController,
          onPressed: () {
            Member updatedMember = Member(
              status_aktif: 1,
              id: member.id,
              nomor_induk: int.tryParse(idNumController.text) ?? 0,
              nama: nameController.text,
              alamat: addressController.text,
              tgl_lahir: birthDateController.text,
              telepon: phoneNumController.text,
            );

            memberBloc.add(EditMember(member: updatedMember));
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }
}
