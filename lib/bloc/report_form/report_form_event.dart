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
  final bool? hasPhysicalDisability;
  final bool? hasMentalDisability;
  const ReportFormEvent({
    this.onHeight,
    this.onAge,
    this.onHairColor,
    this.onSkinColor,
    this.onRecongnizableFeature,
    this.onClothingDescription,
    this.onDescription,
    this.onEducationalLevel,
    this.onVideoLink,
    this.hasMentalDisability,
    this.hasPhysicalDisability,
  });

  @override
  List<Object> get props => [
        onAge!,
        onHeight!,
        onHairColor!,
        onSkinColor!,
        onRecongnizableFeature!,
        onClothingDescription!,
        onDescription!,
        onEducationalLevel!,
        onVideoLink!,
        hasPhysicalDisability!,
        hasMentalDisability!
      ];
}
