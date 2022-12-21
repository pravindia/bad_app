import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/app_configs.dart';
import '../../../../core/constants/constraints/constraints.dart';
import '../../../../core/widgets/dialog/confirmation_dialog.dart';
import '../../../shared/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../blocs/all_records_cubit/all_records_cubit.dart';
import '../blocs/bmi_cubit/bmi_cubit.dart';
import '../widgets/bmi_form.dart';

/// {@template home_page}
/// Home Entry Page.
/// {@endtemplate}
class HomePage extends StatefulWidget {
  /// {@macro home_page}
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.man_rounded),
            Text(localization.appName),
            const Icon(Icons.woman_rounded),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: localization.logout,
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<BmiCubit, BmiState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Text("No Record Found."),
                  loaded: (record) {
                    if (record == null) {
                      return const Text("No Record Found.");
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          record.bmi.toStringAsFixed(2),
                          style: textTheme.headline1?.copyWith(
                            color: record.bmiColor,
                          ),
                        ),
                        Text(
                          "as of ${record.timestamp.toLocal().toString()}",
                          style: textTheme.caption,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Gap(AppConstraints.extraLargeSpace),
            Padding(
              padding: const EdgeInsets.all(
                AppConstraints.mediumSpace,
              ),
              child: Text(
                localization.pastRecords,
                style: textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: BlocBuilder<AllRecordsCubit, AllRecordsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: SizedBox.shrink,
                    loaded: (records) => ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final item = records[index];
                        return ListTile(
                          key: ValueKey("item_${item.id}"),
                          title: Text(
                            item.bmi.toStringAsFixed(2),
                            style: textTheme.headline3?.copyWith(
                              color: item.bmiColor,
                            ),
                          ),
                          subtitle: Text(
                            localization.heightAndWeight(
                              item.height,
                              item.weight,
                            ),
                          ),
                          trailing: Text(item.timestamp.toString()),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addRecord(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> addRecord(BuildContext context) async {
    final cubit = context.read<AllRecordsCubit>();
    await const BmiFormBottomSheet().show(context);
    cubit.fetch();
  }

  Future<void> _logout(BuildContext context) async {
    final authBloc = context.read<AuthBloc>();
    final confirm = await ConfirmationDialog(
      title: localization.sureToLogout,
    ).show(context);
    if (confirm) {
      authBloc.add(const AuthEvent.loggedOut());
    }
  }
}
