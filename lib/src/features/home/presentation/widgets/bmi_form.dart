// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/app_configs.dart';
import '../../../../core/constants/constraints/constraints.dart';
import '../../../../core/utils/validators/validator.dart';
import '../../domain/entities/bmi_record.dart';
import '../blocs/bmi_cubit/bmi_cubit.dart';

class BmiFormBottomSheet extends StatefulWidget {
  const BmiFormBottomSheet({super.key});

  @override
  State<BmiFormBottomSheet> createState() => _BmiFormBottomSheetState();

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) => this,
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1));
  }
}

class _BmiFormBottomSheetState extends State<BmiFormBottomSheet> {
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstraints.mediumSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(AppConstraints.largeSpace),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: localization.height,
                  helperText: localization.heightNote,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: const FormValidator([
                  RequiredValidator(),
                  MinimumValueValidator(minValue: 100),
                  MaximumValueValidator(maxValue: 250),
                ]),
                autofocus: true,
              ),
              const Gap(AppConstraints.mediumSpace),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: localization.weight,
                  helperText: localization.weightNote,
                ),
                onFieldSubmitted: (_) => _create(context),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: const FormValidator([
                  RequiredValidator(),
                  MinimumValueValidator(minValue: 10),
                ]),
              ),
              const Gap(AppConstraints.mediumSpace),
              ElevatedButton(
                onPressed: () => _create(context),
                child: Text(localization.addRecord),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _create(BuildContext context) async {
    final cubit = context.read<BmiCubit>();
    final navigator = Navigator.of(context);

    final formState = _formKey.currentState;

    if (formState == null) return;

    if (formState.validate()) {
      await cubit.saveRecord(
        BMIRecordEntity(
          height: double.parse(_heightController.text),
          weight: double.parse(_weightController.text),
          timestamp: DateTime.now(),
        ),
      );
      // ignore: use_build_context_synchronously
      navigator.pop();
    }
  }
}
