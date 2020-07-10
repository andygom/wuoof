import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/validation.dart';

// class PasswordField extends StatefulWidget {
//   const PasswordField({
//     this.fieldKey,
//     this.maxLength,
//     this.hintText,
//     this.labelText,
//     this.helperText,
//     this.onSaved,
//     this.validator,
//     this.onFieldSubmitted,
//   });

//   final Key fieldKey;
//   final int maxLength;
//   final String hintText;
//   final String labelText;
//   final String helperText;
//   final FormFieldSetter<String> onSaved;
//   final FormFieldValidator<String> validator;
//   final ValueChanged<String> onFieldSubmitted;

//   @override
//   _PasswordFieldState createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: widget.fieldKey,
//       obscureText: _obscureText,
//       maxLength:
//           widget.maxLength ?? 8, // if not provided by the user, then it is 8
//       onSaved: widget.onSaved,
//       validator: widget.validator,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       decoration: InputDecoration(
//         border: const UnderlineInputBorder(),
//         filled: true,
//         hintText: widget.hintText,
//         labelText: widget.labelText,
//         helperText: widget.helperText,
//         suffixIcon: GestureDetector(
//           onTap: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
//         ),
//       ),
//     );
//   }
// }

class SimpleTextField extends StatefulWidget {
  const SimpleTextField({
    this.fieldKey,
    this.label,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.initValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.icon, this.textKeyboardType,
    @required this.textCapitalization,
  });

  final Key fieldKey;
  final int maxLength;
  final int maxLines;
  final bool enabled;
  final String initValue;
  final String label;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final IconData icon;
  final TextInputType textKeyboardType;
  final TextCapitalization textCapitalization;

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  //decoration
  Color colorIcon = Colors.green;
  Color colorErrorBorder = Colors.red;
  Color colorFocusBorder = Colors.blue;
  Color colorEnabledBorder = Colors.green;

  bool _obscureText = true;
  var validator = reviewValidator;

  @override
  Widget build(BuildContext context) {
    switch (widget.label) {
      case ('name'):
        validator = nameValidator;
        break;
      case ('lastName'):
        validator = lastNameValidator;
        break;
      case ('password'):
        validator = passwordValidator;
        break;
      case ('passwordConfirm'):
        validator = passwordDataBaseValidator;
        break;
      case ('email'):
        validator = emailValidator;
        break;
      case ('phone'):
        validator = phoneValidator;
        break;
      case ('review'):
        validator = reviewValidator;
        break;
      case ('nationality'):
        validator = nationalityValidator;
        break;
      case ('bio'):
        validator = biographyValidator;
        break;
      case ('petName'):
        validator = petNameValidator;
        break;
      default:
        validator = genericValidator;
        break;
    }
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled ? true : false,
      key: widget.fieldKey,
      obscureText:
          widget.label == 'password' || widget.label == 'passwordConfirm'
              ? _obscureText
              : false,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      validator: validator,
      keyboardType: widget.label == 'phone'  ?  TextInputType.number :null,
      inputFormatters:  widget.label == 'phone'  ? [WhitelistingTextInputFormatter.digitsOnly] : null,
      // onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initValue,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        suffixIcon:
            widget.label == 'password' || widget.label == 'passwordConfirm'
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: colorIcon),
                  )
                : Icon(
                    widget.icon,
                    color: colorIcon,
                  ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorEnabledBorder),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorFocusBorder),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorErrorBorder),
        ),
        errorStyle: TextStyle(color: colorErrorBorder),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorErrorBorder),
        ),
      ),
    );
  }
}

class DropDownField extends StatefulWidget {
  const DropDownField(
      {this.fbKey,
      this.attribute,
      this.labelText,
      this.initValue,
      this.itemsList,
      this.onChanged,
      this.validator,
      this.enabled});

  final GlobalKey fbKey;
  final String initValue;
  final String attribute, labelText;
  final List<DropdownMenuItem<String>> itemsList;
  final FormFieldSetter<String> onChanged;
  final Function validator;
  final bool enabled;

  @override
  _DropDownFieldState createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  //decoration
  Color colorIcon = Colors.green;
  Color colorErrorBorder = Colors.red;
  Color colorFocusBorder = Colors.blue;
  Color colorEnabledBorder = Colors.green;

  bool _obscureText = true;
  var validator = reviewValidator;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.enabled ? false : true,
          child: DropdownButtonFormField<String>(
        value: widget.initValue,
        
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
        isExpanded: true,
        onChanged: widget.onChanged,
        items: widget.itemsList,
        validator: (value) => value == null ? 'Este campo es requerido' : null,
      ),
    );
  }
}
