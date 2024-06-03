import 'package:explora_app/helper/transactions/transactions_list.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => memberBloc..add(LoadMember()),
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
                            Container(
                              decoration: BoxDecoration(color: themeColor),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.nama,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            child: member.telepon,
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.w500),
                                        MyText(
                                            child: " || ",
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.w500),
                                        MyText(
                                            child:
                                                "No Induk: ${member.nomor_induk.toString()}",
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.w500)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    MyText(
                                        child:
                                            "ID\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t: ${member.id}",
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.w500),
                                    MyText(
                                        child:
                                            "Alamat\t\t\t\t\t\t\t\t\t\t\t\t\t: ${member.alamat}",
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.w500),
                                    MyText(
                                        child:
                                            "Tanggal Lahir\t: ${member.tgl_lahir}",
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CoolButton(
                                            textColor: themeColor,
                                            text: "Edit / Delete",
                                            color: white,
                                            onTap: () {
                                              _showEditDeleteDialog(member);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TransactionList(id: member.id)
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
