part of 'report_form_bloc.dart';

class ReportFormEvent extends SharedEvent {
  final int? onAge;
  final double? onHeight;
  final String? onHairColor;
  final String? onSkinColor;
  final String? onRecongnizableFeature;
  final String? onDescription;
  final String? onEducationalLevel;
  final String? onVideoLink;
  final String? onClothingDescription;

  final String selected;

  final String physicalDisability;
  final String? otherPhysicalDisability;
  final String mentalDisability;
  final String? otherMentalDisability;

  const ReportFormEvent({
    this.physicalDisability = "",
    this.otherPhysicalDisability = "",
    this.mentalDisability = "",
    this.otherMentalDisability = "",
    this.selected = "",
    this.onHeight,
    this.onAge,
    this.onHairColor,
    this.onSkinColor,
    this.onRecongnizableFeature,
    this.onClothingDescription,
    this.onDescription,
    this.onEducationalLevel,
    this.onVideoLink,
  });

  @override
  List<Object> get props => [
        physicalDisability,
        otherPhysicalDisability!,
        mentalDisability,
        otherMentalDisability!,
        selected,
        onAge!,
        onHeight!,
        onHairColor!,
        onSkinColor!,
        onRecongnizableFeature!,
        onClothingDescription!,
        onDescription!,
        onEducationalLevel!,
        onVideoLink!,
      ];
}
