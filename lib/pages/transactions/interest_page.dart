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
                floatingActionButton: FloatingActionButton(
                    foregroundColor: white,
                    backgroundColor: themeColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider<InterestBloc>.value(
                                value: context.read<InterestBloc>(),
                                child: Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                            child: "Manage Interest",
                                            fontSize: 16,
                                            color: black,
                                            fontWeight: FontWeight.w600),
                                        MyTextField(
                                            onTap: () {},
                                            hintText: "Set Interest Percentage",
                                            controller: percentController),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        CoolButton(
                                          onTap: () {
                                            Bunga bunga = Bunga(
                                                persen: double.tryParse(
                                                        percentController
                                                            .text) ??
                                                    0,
                                                isaktif: 1);
                                            context
                                                .read<InterestBloc>()
                                                .add(AddInterest(bunga: bunga));
                                          },
                                          text: "Set",
                                          color: themeColor,
                                          textColor: themeColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: Icon(
                      Icons.add,
                      color: white,
                    )),
                backgroundColor: white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: MyText(
                            child: 'Interest',
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: CircularProgressIndicator(
                                value: current / 10,
                                backgroundColor: grey,
                                valueColor: AlwaysStoppedAnimation(lightGreen),
                              ),
                            ),
                            MyText(
                                child: '$current%',
                                fontSize: 16,
                                color: themeColor,
                                fontWeight: FontWeight.bold),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          MyText(
                              child: "Interest History",
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: interest.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyText(
                                      child: '${interest[index].persen}%',
                                      fontSize: 16,
                                      color: themeColor,
                                      fontWeight: FontWeight.w500),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
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
