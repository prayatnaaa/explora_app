import 'dart:async';

import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/remote_datasource.dart';
import 'package:explora_app/helper/member_button.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/utils/cool_button.dart';
import 'package:explora_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

final MemberBloc memberBloc = MemberBloc(remoteDataSource: RemoteDataSource());

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final nameController = TextEditingController();
    final birthDateController = TextEditingController();
    final idNumController = TextEditingController();
    final phoneNumController = TextEditingController();
    return BlocProvider(
      create: (context) => memberBloc..add(LoadMember()),
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, memberState) {
          if (memberState is MemberInitial ||
              memberState is MemberAdded ||
              memberState is MemberDeleted ||
              memberState is MemberEdited) {
            BlocProvider.of<MemberBloc>(context).add(LoadMember());
          } else if (memberState is MemberLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (memberState is MemberLoaded) {
            final members = memberState.members;

            return Scaffold(
              backgroundColor: Colors.grey,
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Add Member"),
                          content: MemberButton(
                            addressController: addressController,
                            nameController: nameController,
                            phoneNumController: phoneNumController,
                            idNumController: idNumController,
                            birthDateController: birthDateController,
                            onPressed: () {
                              Member member = Member(
                                  nomor_induk:
                                      int.tryParse(idNumController.text) ?? 0,
                                  nama: nameController.text,
                                  alamat: addressController.text,
                                  tgl_lahir: birthDateController.text,
                                  telepon: phoneNumController.text);

                              memberBloc.add(AddMember(member: member));
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        );
                      },
                    );
                  }),
              body: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.person,
                                      color: themeColor,
                                      size: 80,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  //member name
                                  Text(
                                    members[index].nama,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeColor,
                                    ),
                                  ),
                                  //member nomor_induk
                                  MyText(
                                    child:
                                        members[index].nomor_induk.toString(),
                                    fontSize: 16,
                                    color: themeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  //member telepon
                                  MyText(
                                    child: members[index].telepon,
                                    fontSize: 12,
                                    color: themeColor,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ]),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CoolButton(
                                        text: 'Edit',
                                        color: Colors.yellow,
                                        onTap: () {
                                          setState(() {
                                            addressController.text =
                                                members[index].alamat;
                                            nameController.text =
                                                members[index].nama;
                                            phoneNumController.text =
                                                members[index].telepon;
                                            idNumController.text =
                                                members[index]
                                                    .nomor_induk
                                                    .toString();
                                            birthDateController.text =
                                                members[index].tgl_lahir;
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Edit Member"),
                                                content: MemberButton(
                                                  addressController:
                                                      addressController,
                                                  nameController:
                                                      nameController,
                                                  phoneNumController:
                                                      phoneNumController,
                                                  idNumController:
                                                      idNumController,
                                                  birthDateController:
                                                      birthDateController,
                                                  onPressed: () {
                                                    Member member = Member(
                                                        status_aktif: 1,
                                                        id: members[index].id,
                                                        nomor_induk: int.tryParse(
                                                                idNumController
                                                                    .text) ??
                                                            0,
                                                        nama:
                                                            nameController.text,
                                                        alamat:
                                                            addressController
                                                                .text,
                                                        tgl_lahir:
                                                            birthDateController
                                                                .text,
                                                        telepon:
                                                            phoneNumController
                                                                .text);

                                                    memberBloc.add(EditMember(
                                                        member: member));
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                    CoolButton(
                                        text: "Delete",
                                        color: Colors.red,
                                        onTap: () {
                                          memberBloc.add(DeleteMember(
                                              id: members[index].id));
                                        })
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
    );
  }
}
