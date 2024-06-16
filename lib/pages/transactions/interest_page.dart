import 'package:explora_app/components/button.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/data/bloc/interest_bloc/interest_bloc.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/datasources/transaction_datasource.dart';
import 'package:explora_app/helper/transactions/add_transaction_dialog.dart';
import 'package:explora_app/models/interest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController percentController = TextEditingController();
    return BlocProvider(
      create: (context) =>
          InterestBloc(transactionDatasource: TransactionDatasource())
            ..add(LoadInterest()),
      child: BlocListener<InterestBloc, InterestState>(
        listener: (context, state) {
          if (state is InterestAdded) {
            context.read<InterestBloc>().add(LoadInterest());
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<InterestBloc, InterestState>(
          builder: (context, state) {
            if (state is InterestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InterestLoaded) {
              final interest = state.bunga;
              final current = state.currentBunga.aktifBunga.persen;
              return Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => BlocProvider<InterestBloc>.value(
                            value: context.read<InterestBloc>(),
                            child: Dialog(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyTextField(
                                        onTap: () {},
                                        hintText: "hintText",
                                        controller: percentController),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    CoolButton(
                                      onTap: () {
                                        Bunga bunga = Bunga(
                                            persen: double.tryParse(
                                                    percentController.text) ??
                                                0,
                                            isaktif: 1);
                                        context
                                            .read<InterestBloc>()
                                            .add(AddInterest(bunga: bunga));
                                      },
                                      text: "Manage Interest",
                                      color: themeColor,
                                      textColor: white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                }),
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: themeColor),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: MyText(
                              child: current.toString(),
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: interest.length,
                            itemBuilder: (context, index) {
                              return Text(interest[index].persen.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: false,
                      child: Center(
                        child: Container(
                          color: grey,
                          child: Column(
                            children: [
                              MyTextField(
                                  onTap: () {},
                                  hintText: "Tes",
                                  controller: percentController),
                              ElevatedButton(
                                  onPressed: () {
                                    Bunga bunga = Bunga(
                                        persen: double.tryParse(
                                                percentController.text) ??
                                            0,
                                        isaktif: 1);
                                    context
                                        .read<InterestBloc>()
                                        .add(AddInterest(bunga: bunga));
                                    print(state);
                                  },
                                  child: const Text("hi"))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: Text("tes"),
            );
          },
        ),
      ),
    );
  }
}
