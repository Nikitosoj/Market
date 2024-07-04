import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatefulWidget {
  final Function(String) onPhoneValid;
  final VoidCallback onSubmitted;
  final TextEditingController? controller;

  const PhoneInputField({
    required this.onPhoneValid,
    super.key,
    required this.onSubmitted,
    this.controller,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _phoneNumberWithCode = '';
  bool _isButtonEnabled = false;

  void _onPhoneChanged(String phoneWithCode) {
    setState(() {
      _phoneNumberWithCode = phoneWithCode;
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
      if (_isButtonEnabled) {
        widget.onPhoneValid(_phoneNumberWithCode);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        setState(() {
          _isButtonEnabled = _formKey.currentState?.validate() ?? false;
          if (_isButtonEnabled) {
            widget.onPhoneValid(_phoneNumberWithCode);
          }
        });
      },
      child: Column(
        children: [
          IntlPhoneField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            focusNode: FocusNode(),
            style: const TextStyle(fontSize: 16),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: 'Введите номер телефона',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'RU',
            onSubmitted: (phone) {
              if (_isButtonEnabled) {
                widget.onSubmitted();
              }
            },
            onChanged: (phone) {
              _onPhoneChanged(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }
}
