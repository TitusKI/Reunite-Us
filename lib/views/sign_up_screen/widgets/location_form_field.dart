import 'package:afalagi/bloc/profile/create_profile/create_profile_bloc.dart';
import 'package:afalagi/bloc/profile/create_profile/create_profile_state.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationFormField extends FormField<Map<String, String?>> {
  LocationFormField({
    super.key,
    required FormFieldSetter<Map<String, String?>> super.onSaved,
    required FormFieldValidator<Map<String, String?>> super.validator,
    Map<String, String?> super.initialValue = const {
      "country": null,
      "state": null,
      "city": null,
    },
    bool autovalidate = false,
    required BuildContext context,
  }) : super(
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<Map<String, String?>> state) {
            return BlocBuilder<CreateProfileBloc, CreateProfileState>(
              builder: (context, states) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.ENABLE,
                      dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      selectedItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      dropdownHeadingStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      dropdownItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      countrySearchPlaceholder: "Search Country",
                      stateSearchPlaceholder: "Search State",
                      citySearchPlaceholder: "Search City",
                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",
                      onCountryChanged: (value) {
                        state.didChange({
                          ...state.value!,
                          'country': value,
                          'state': null,
                          'city': null,
                        });
                        print(value);
                        context
                            .read<CreateProfileBloc>()
                            .add(LocationEvent(country: value));
                      },
                      onStateChanged: (value) {
                        print(value);
                        state.didChange({
                          ...state.value!,
                          'state': value,
                          'city': null,
                        });
                        context
                            .read<CreateProfileBloc>()
                            .add(LocationEvent(state: value));
                      },
                      onCityChanged: (value) {
                        print(value);
                        state.didChange({
                          ...state.value!,
                          'city': value,
                        });
                        context
                            .read<CreateProfileBloc>()
                            .add(LocationEvent(city: value));
                      },
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
}
