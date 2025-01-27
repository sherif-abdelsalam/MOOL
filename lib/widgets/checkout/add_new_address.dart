import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/singing/input_filed_deocration.dart';

class AddNewAddress extends ConsumerStatefulWidget {
  const AddNewAddress({super.key, required this.onConfirmAddress});
  final void Function() onConfirmAddress;
  @override
  ConsumerState<AddNewAddress> createState() {
    return _AddNewAddressState();
  }
}

class _AddNewAddressState extends ConsumerState<AddNewAddress> {
  final _formKey = GlobalKey<FormState>();
  final _address = ShippingAddress();
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    void _saveForm() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.watch(addressesProvider.notifier).addAddress(_address);
        widget.onConfirmAddress();
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<Country>(
                  decoration: InputDecoration(
                    labelText: 'Country',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  items: countries
                      .map((Country country) => DropdownMenuItem(
                            value: country,
                            child: Row(
                              children: [
                                Text(country.flag),
                                SizedBox(width: 8),
                                Text(
                                  country.name.split(" ").first,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (Country? value) {
                    setState(() {
                      selectedCountry = value;
                      if (value != null) {
                        _address.country = value.name;
                      }
                    });
                  },
                  onSaved: (Country? value) {
                    if (value != null) {
                      _address.country = value.name;
                    }
                  },
                ),
                SizedBox(height: 16),
                InputFiledDecoration(
                  labelText: 'Full Name',
                  onSaveInput: (value) {
                    _address.fullName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 0),
                      ),
                      child: Text(
                        selectedCountry?.dialCode == null
                            ? "Code"
                            : "+${selectedCountry?.dialCode}",
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 120, 120, 120)),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: InputFiledDecoration(
                        labelText: 'Phone Number',
                        onSaveInput: (value) {
                          if (selectedCountry != null) {
                            _address.phoneNumber =
                                selectedCountry!.dialCode + value;
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          if (selectedCountry != null) {
                            if (value.length < selectedCountry!.minLength ||
                                value.length > selectedCountry!.maxLength) {
                              return 'Phone number must be ${selectedCountry!.minLength} digits';
                            }
                          } else {
                            return 'Please select a country first';
                          }
                          return null;
                        },
                        isPassword: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                InputFiledDecoration(
                  labelText: 'Street name',
                  onSaveInput: (value) {
                    _address.streetName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street name';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: 16),
                InputFiledDecoration(
                  labelText: 'Building name / no',
                  onSaveInput: (value) {
                    _address.buildingNameOrNumber = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter building name or number';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: 16),
                InputFiledDecoration(
                  labelText: 'City / Area',
                  onSaveInput: (value) {
                    _address.cityOrArea = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city or area';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: 16),
                InputFiledDecoration(
                  labelText: 'Nearest landmark',
                  onSaveInput: (value) {
                    _address.nearestLandmark = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter nearest landmark';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Button(
            btnText: "Confirm and continue", onTapBtn: _saveForm)
      ],
    );
  }
}
