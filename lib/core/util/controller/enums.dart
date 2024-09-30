// ignore_for_file: constant_identifier_names

enum Role { User, Admin, SuperAdmin, Guest }

enum Gender { Male, Female }

enum HairColor { Black, Brown, White, Blonde, Grey, Orange, Other }

enum EducationalLevel {
  None,
  Primary,
  Secondary,
  Highschool,
  Associate,
  Bachelor,
  Master,
  Doctorate,
  Other
}

enum SkinColor { White, Lightskin, Brown, Dark, Other }

enum MedicalIssues {
  None,
  Diabetes,
  Asthma,
  Hypertension,
  HeartDisease,
  AutoimmuneDisorder,
  Epilepsy,
  MultipleSclerosis,
  Lupus,
  CrohnsDisease,
  ChronicKidneyDisease,
  Migraine,
  Fibromyalgia,
  Psoriasis,
  IrritableBowelSyndrome,
  ParkinsonsDisease,
  Cancer,
  Other
}

enum MentalDisability {
  None,
  IntellectualDisability,
  AutismSpectrumDisorder,
  ADHD,
  Schizophrenia,
  BipolarDisorder,
  AnxietyDisorder,
  Depression,
  OCD,
  PTSD,
  Dementia,
  Other
}

enum PhysicalDisability {
  None,
  MobilityIssue,
  VisionImpairment,
  HearingLoss,
  NeurologicalCondition,
  NonVerbal,
  LimbDifference,
  Other
}

enum PostStatus { UnderReview, Rejected, Open, Closed, Removed }

enum MaritalStatus {
  Single,
  Married,
  Divorced,
  Widowed,
  Engaged,
  PreferNotToSay
}

enum PosterRelation {
  Parent,
  Sibling,
  Partner,
  Relative,
  Friend,
  Guardian,
  Neighbor,
  Colleague,
  Teacher,
  Other
}

enum FoundCondition {
  Alive_Well,
  Injured,
  Sick,
  Unresponsive,
  Deceased,
  Unknown
}

enum FoundThrough {
  Afalagi,
  Police,
  Community_Search,
  Family_Friends,
  Social_Media,
  Medical_Institutional,
  Other
}

extension DisabilityExtension on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
