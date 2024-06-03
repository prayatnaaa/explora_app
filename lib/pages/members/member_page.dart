import 'dart:async';

import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:explora_app/helper/member_button.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/pages/members/member_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final MemberBloc memberBloc =
      MemberBloc(remoteDataSource: RemoteDataSource());
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
            return Center(
              child: CircularProgressIndicator(
                color: themeColor,
              ),
            );
          } else if (memberState is MemberLoaded) {
            final members = memberState.members;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColor,
                foregroundColor: white,
                title: MyText(
                    child: "Members",
                    fontSize: 24,
                    color: white,
                    fontWeight: FontWeight.w600),
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: themeColor,
                  hoverColor: themeColor,
                  child: Icon(
                    Icons.add,
                    color: white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MemberButton(
                          title: "Add Member",
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
                        );
                      },
                    );
                  }),
              body: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                        border: Border.all(color: themeColor)),
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      members[index].nama,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: themeColor,
                                      ),
                                    ),
                                    //member nomor_induk

                                    //member telepon
                                    MyText(
                                      child: members[index].telepon,
                                      fontSize: 12,
                                      color: themeColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        MyText(
                                                          child:
                                                              "Member Actions",
                                                          fontSize: 18,
                                                          color: themeColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        const SizedBox(
                                                            height: 24),
                                                        CoolButton(
                                                          text: 'Edit',
                                                          color: Colors
                                                              .yellow[700],
                                                          onTap: () {
                                                            setState(() {
                                                              addressController
                                                                      .text =
                                                                  members[index]
                                                                      .alamat;
                                                              nameController
                                                                      .text =
                                                                  members[index]
                                                                      .nama;
                                                              phoneNumController
                                                                      .text =
                                                                  members[index]
                                                                      .telepon;
                                                              idNumController
                                                                  .text = members[
                                                                      index]
                                                                  .nomor_induk
                                                                  .toString();
                                                              birthDateController
                                                                      .text =
                                                                  members[index]
                                                                      .tgl_lahir;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return MemberButton(
                                                                  title: "Edit",
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
                                                                  onPressed:
                                                                      () {
                                                                    Member member = Member(
                                                                        status_aktif:
                                                                            1,
                                                                        id: members[index]
                                                                            .id,
                                                                        nomor_induk:
                                                                            int.tryParse(idNumController.text) ??
                                                                                0,
                                                                        nama: nameController
                                                                            .text,
                                                                        alamat: addressController
                                                                            .text,
                                                                        tgl_lahir:
                                                                            birthDateController
                                                                                .text,
                                                                        telepon:
                                                                            phoneNumController.text);

                                                                    memberBloc.add(
                                                                        EditMember(
                                                                            member:
                                                                                member));
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        CoolButton(
                                                          text: "Delete",
                                                          color: Colors.red,
                                                          onTap: () {
                                                            memberBloc.add(
                                                                DeleteMember(
                                                                    id: members[
                                                                            index]
                                                                        .id));
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.settings,
                                          color: themeColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MemberProfile(
                                                          index: index)));
                                        },
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: themeColor,
                                        ))
                                  ],
                                ),

                                //member name
                              ])
                        ],
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
