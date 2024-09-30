import 'enums.dart';

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.Male:
      return 'Male';
    case Gender.Female:
      return 'Female';
  }
}

Gender stringToGender(String gender) {
  switch (gender) {
    case 'Male':
      return Gender.Male;
    case 'Female':
      return Gender.Female;
    default:
      throw ArgumentError('Invalid gender: $gender');
  }
}

String hairColorToString(HairColor hairColor) {
  switch (hairColor) {
    case HairColor.Black:
      return 'Black';
    case HairColor.Brown:
      return 'Brown';
    case HairColor.White:
      return 'White';
    case HairColor.Blonde:
      return 'Blonde';
    case HairColor.Grey:
      return 'Grey';
    case HairColor.Orange:
      return 'Orange';
    case HairColor.Other:
      return 'Other';
  }
}

HairColor stringToHairColor(String hairColor) {
  switch (hairColor) {
    case 'Black':
      return HairColor.Black;
    case 'Brown':
      return HairColor.Brown;
    case 'White':
      return HairColor.White;
    case 'Blonde':
      return HairColor.Blonde;
    case 'Grey':
      return HairColor.Grey;
    case 'Orange':
      return HairColor.Orange;
    case 'Other':
      return HairColor.Other;
    default:
      throw ArgumentError('Invalid hair color: $hairColor');
  }
}

String educationalLevelToString(EducationalLevel educationalLevel) {
  switch (educationalLevel) {
    case EducationalLevel.None:
      return 'None';
    case EducationalLevel.Primary:
      return 'Primary';
    case EducationalLevel.Secondary:
      return 'Secondary';
    case EducationalLevel.Highschool:
      return 'Highschool';
    case EducationalLevel.Associate:
      return 'Associate';
    case EducationalLevel.Bachelor:
      return 'Bachelor';
    case EducationalLevel.Master:
      return 'Master';
    case EducationalLevel.Doctorate:
      return 'Doctorate';
    case EducationalLevel.Other:
      return 'Other';
  }
}

String foundConditionToString(FoundCondition condition) {
  switch (condition) {
    case FoundCondition.Alive_Well:
      return 'Alive_Well';
    case FoundCondition.Injured:
      return 'Injured';
    case FoundCondition.Sick:
      return 'Sick';
    case FoundCondition.Unresponsive:
      return 'Unresponsive';
    case FoundCondition.Deceased:
      return 'Deceased';
    case FoundCondition.Unknown:
      return 'Unknown';
  }
}

FoundCondition stringToFoundCondition(String conditionString) {
  switch (conditionString) {
    case 'Alive and Well':
      return FoundCondition.Alive_Well;
    case 'Injured':
      return FoundCondition.Injured;
    case 'Sick':
      return FoundCondition.Sick;
    case 'Unresponsive':
      return FoundCondition.Unresponsive;
    case 'Deceased':
      return FoundCondition.Deceased;
    case 'Unknown':
      return FoundCondition.Unknown;
    default:
      throw ArgumentError('Invalid found condition: $conditionString');
  }
}

EducationalLevel stringToEducationalLevel(String educationalLevel) {
  switch (educationalLevel) {
    case 'None':
      return EducationalLevel.None;
    case 'Primary':
      return EducationalLevel.Primary;
    case 'Secondary':
      return EducationalLevel.Secondary;
    case 'Highschool':
      return EducationalLevel.Highschool;
    case 'Associate':
      return EducationalLevel.Associate;
    case 'Bachelor':
      return EducationalLevel.Bachelor;
    case 'Master':
      return EducationalLevel.Master;
    case 'Doctorate':
      return EducationalLevel.Doctorate;
    case 'Other':
      return EducationalLevel.Other;
    default:
      throw ArgumentError('Invalid educational level: $educationalLevel');
  }
}

String skinColorToString(SkinColor skinColor) {
  switch (skinColor) {
    case SkinColor.White:
      return 'White';
    case SkinColor.Lightskin:
      return 'Lightskin';
    case SkinColor.Brown:
      return 'Brown';
    case SkinColor.Dark:
      return 'Dark';
    case SkinColor.Other:
      return 'Other';
  }
}

SkinColor stringToSkinColor(String skinColor) {
  switch (skinColor) {
    case 'White':
      return SkinColor.White;
    case 'Lightskin':
      return SkinColor.Lightskin;
    case 'Brown':
      return SkinColor.Brown;
    case 'Dark':
      return SkinColor.Dark;
    case 'Other':
      return SkinColor.Other;
    default:
      throw ArgumentError('Invalid skin color: $skinColor');
  }
}

String foundThroughToString(FoundThrough foundThrough) {
  switch (foundThrough) {
    case FoundThrough.Afalagi:
      return 'Afalgi';
    case FoundThrough.Community_Search:
      return 'Community_Search';
    case FoundThrough.Police:
      return 'Police';
    case FoundThrough.Medical_Institutional:
      return 'Medical_Institutional';
    case FoundThrough.Other:
      return 'Other';
    case FoundThrough.Social_Media:
      return 'Social_Media';
    case FoundThrough.Family_Friends:
      return 'Family_Friends';
  }
}

FoundThrough stringToFoundThrough(String methodString) {
  switch (methodString) {
    case 'Afalagi':
      return FoundThrough.Afalagi;
    case 'Police':
      return FoundThrough.Police;
    case 'Community_Search':
      return FoundThrough.Community_Search;
    case 'Family_Friends':
      return FoundThrough.Family_Friends;
    case 'Social_Media':
      return FoundThrough.Social_Media;
    case 'Medical_Institution':
      return FoundThrough.Medical_Institutional;
    case 'Other':
      return FoundThrough.Other;
    default:
      throw ArgumentError('Invalid medical issue: $methodString');
  }
}

String medicalIssuesToString(MedicalIssues medicalIssues) {
  switch (medicalIssues) {
    case MedicalIssues.None:
      return 'NONE';
    case MedicalIssues.Diabetes:
      return 'DIABETES';
    case MedicalIssues.Asthma:
      return 'ASTHMA';
    case MedicalIssues.Hypertension:
      return 'HYPERTENSION';
    case MedicalIssues.HeartDisease:
      return 'HEART_DISEASE';
    case MedicalIssues.AutoimmuneDisorder:
      return 'AUTOIMMUNE_DISORDER';
    case MedicalIssues.Epilepsy:
      return 'EPILEPSY';
    case MedicalIssues.MultipleSclerosis:
      return 'MULTIPLE_SCLEROSIS';
    case MedicalIssues.Lupus:
      return 'LUPUS';
    case MedicalIssues.CrohnsDisease:
      return 'CROHNS_DISEASE';
    case MedicalIssues.ChronicKidneyDisease:
      return 'CHRONIC_KIDNEY_DISEASE';
    case MedicalIssues.Migraine:
      return 'MIGRAINE';
    case MedicalIssues.Fibromyalgia:
      return 'FIBROMYALGIA';
    case MedicalIssues.Psoriasis:
      return 'PSORIASIS';
    case MedicalIssues.IrritableBowelSyndrome:
      return 'IRRITABLE_BOWEL_SYNDROME';
    case MedicalIssues.ParkinsonsDisease:
      return 'PARKINSONS_DISEASE';
    case MedicalIssues.Cancer:
      return 'CANCER';
    case MedicalIssues.Other:
      return 'OTHER';
  }
}

MedicalIssues stringToMedicalIssues(String medicalIssues) {
  switch (medicalIssues) {
    case 'None':
      return MedicalIssues.None;
    case 'Diabetes':
      return MedicalIssues.Diabetes;
    case 'Asthma':
      return MedicalIssues.Asthma;
    case 'Hypertension':
      return MedicalIssues.Hypertension;
    case 'HeartDisease':
      return MedicalIssues.HeartDisease;
    case 'AutoimmuneDisorder':
      return MedicalIssues.AutoimmuneDisorder;
    case 'Epilepsy':
      return MedicalIssues.Epilepsy;
    case 'MultipleSclerosis':
      return MedicalIssues.MultipleSclerosis;
    case 'Lupus':
      return MedicalIssues.Lupus;
    case 'CrohnsDisease':
      return MedicalIssues.CrohnsDisease;
    case 'ChronicKidneyDisease':
      return MedicalIssues.ChronicKidneyDisease;
    case 'Migraine':
      return MedicalIssues.Migraine;
    case 'Fibromyalgia':
      return MedicalIssues.Fibromyalgia;
    case 'Psoriasis':
      return MedicalIssues.Psoriasis;
    case 'IrritableBowelSyndrome':
      return MedicalIssues.IrritableBowelSyndrome;
    case 'ParkinsonsDisease':
      return MedicalIssues.ParkinsonsDisease;
    case 'Cancer':
      return MedicalIssues.Cancer;
    case 'Other':
      return MedicalIssues.Other;
    default:
      throw ArgumentError('Invalid medical issue: $medicalIssues');
  }
}

String mentalDisabilityToString(MentalDisability mentalDisability) {
  switch (mentalDisability) {
    case MentalDisability.None:
      return 'None';
    case MentalDisability.IntellectualDisability:
      return 'IntellectualDisability';
    case MentalDisability.AutismSpectrumDisorder:
      return 'AutismSpectrumDisorder';
    case MentalDisability.ADHD:
      return 'ADHD';
    case MentalDisability.Schizophrenia:
      return 'Schizophrenia';
    case MentalDisability.BipolarDisorder:
      return 'BipolarDisorder';
    case MentalDisability.AnxietyDisorder:
      return 'AnxietyDisorder';
    case MentalDisability.Depression:
      return 'Depression';
    case MentalDisability.OCD:
      return 'OCD';
    case MentalDisability.PTSD:
      return 'PTSD';
    case MentalDisability.Dementia:
      return 'Dementia';
    case MentalDisability.Other:
      return 'Other';
  }
}

MentalDisability stringToMentalDisability(String mentalDisability) {
  switch (mentalDisability) {
    case 'None':
      return MentalDisability.None;
    case 'IntellectualDisability':
      return MentalDisability.IntellectualDisability;
    case 'AutismSpectrumDisorder':
      return MentalDisability.AutismSpectrumDisorder;
    case 'ADHD':
      return MentalDisability.ADHD;
    case 'Schizophrenia':
      return MentalDisability.Schizophrenia;
    case 'BipolarDisorder':
      return MentalDisability.BipolarDisorder;
    case 'AnxietyDisorder':
      return MentalDisability.AnxietyDisorder;
    case 'Depression':
      return MentalDisability.Depression;
    case 'OCD':
      return MentalDisability.OCD;
    case 'PTSD':
      return MentalDisability.PTSD;
    case 'Dementia':
      return MentalDisability.Dementia;
    case 'Other':
      return MentalDisability.Other;
    default:
      throw ArgumentError('Invalid mental disability: $mentalDisability');
  }
}

String physicalDisabilityToString(PhysicalDisability physicalDisability) {
  switch (physicalDisability) {
    case PhysicalDisability.None:
      return 'None';
    case PhysicalDisability.MobilityIssue:
      return 'MobilityIssue';
    case PhysicalDisability.VisionImpairment:
      return 'VisionImpairment';
    case PhysicalDisability.HearingLoss:
      return 'HearingLoss';
    case PhysicalDisability.NeurologicalCondition:
      return 'NeurologicalCondition';
    case PhysicalDisability.NonVerbal:
      return 'NonVerbal';
    case PhysicalDisability.LimbDifference:
      return 'LimbDifference';
    case PhysicalDisability.Other:
      return 'Other';
  }
}

PhysicalDisability stringToPhysicalDisability(String physicalDisability) {
  switch (physicalDisability) {
    case 'None':
      return PhysicalDisability.None;
    case 'MobilityIssue':
      return PhysicalDisability.MobilityIssue;
    case 'VisionImpairment':
      return PhysicalDisability.VisionImpairment;
    case 'HearingLoss':
      return PhysicalDisability.HearingLoss;
    case 'NeurologicalCondition':
      return PhysicalDisability.NeurologicalCondition;
    case 'NonVerbal':
      return PhysicalDisability.NonVerbal;
    case 'LimbDifference':
      return PhysicalDisability.LimbDifference;
    case 'Other':
      return PhysicalDisability.Other;
    default:
      throw ArgumentError('Invalid physical disability: $physicalDisability');
  }
}

String postStatusToString(PostStatus postStatus) {
  switch (postStatus) {
    case PostStatus.UnderReview:
      return 'UnderReview';
    case PostStatus.Rejected:
      return 'Rejected';
    case PostStatus.Open:
      return 'Open';
    case PostStatus.Closed:
      return 'Closed';
    case PostStatus.Removed:
      return 'Removed';
  }
}

PostStatus stringToPostStatus(String postStatus) {
  switch (postStatus) {
    case 'UnderReview':
      return PostStatus.UnderReview;
    case 'Rejected':
      return PostStatus.Rejected;
    case 'Open':
      return PostStatus.Open;
    case 'Closed':
      return PostStatus.Closed;
    case 'Removed':
      return PostStatus.Removed;
    default:
      throw ArgumentError('Invalid post status: $postStatus');
  }
}

String maritalStatusToString(MaritalStatus maritalStatus) {
  switch (maritalStatus) {
    case MaritalStatus.Single:
      return 'Single';
    case MaritalStatus.Married:
      return 'Married';
    case MaritalStatus.Divorced:
      return 'Divorced';
    case MaritalStatus.Widowed:
      return 'Widowed';
    case MaritalStatus.Engaged:
      return 'Engaged';
    case MaritalStatus.PreferNotToSay:
      return 'PreferNotToSay';
  }
}

MaritalStatus stringToMaritalStatus(String maritalStatus) {
  switch (maritalStatus) {
    case 'Single':
      return MaritalStatus.Single;
    case 'Married':
      return MaritalStatus.Married;
    case 'Divorced':
      return MaritalStatus.Divorced;
    case 'Widowed':
      return MaritalStatus.Widowed;
    case 'Engaged':
      return MaritalStatus.Engaged;
    case 'PreferNotToSay':
      return MaritalStatus.PreferNotToSay;
    default:
      throw ArgumentError('Invalid marital status: $maritalStatus');
  }
}

String posterRelationToString(PosterRelation posterRelation) {
  switch (posterRelation) {
    case PosterRelation.Parent:
      return 'Parent';
    case PosterRelation.Sibling:
      return 'Sibling';
    case PosterRelation.Partner:
      return 'Partner';
    case PosterRelation.Relative:
      return 'Relative';
    case PosterRelation.Friend:
      return 'Friend';
    case PosterRelation.Guardian:
      return 'Guardian';
    case PosterRelation.Neighbor:
      return 'Neighbor';
    case PosterRelation.Colleague:
      return 'Colleague';
    case PosterRelation.Teacher:
      return 'Teacher';
    case PosterRelation.Other:
      return 'Other';
  }
}

PosterRelation stringToPosterRelation(String posterRelation) {
  switch (posterRelation) {
    case 'Parent':
      return PosterRelation.Parent;
    case 'Sibling':
      return PosterRelation.Sibling;
    case 'Partner':
      return PosterRelation.Partner;
    case 'Relative':
      return PosterRelation.Relative;
    case 'Friend':
      return PosterRelation.Friend;
    case 'Guardian':
      return PosterRelation.Guardian;
    case 'Neighbor':
      return PosterRelation.Neighbor;
    case 'Colleague':
      return PosterRelation.Colleague;
    case 'Teacher':
      return PosterRelation.Teacher;
    case 'Other':
      return PosterRelation.Other;
    default:
      throw ArgumentError('Invalid poster relation: $posterRelation');
  }
}
