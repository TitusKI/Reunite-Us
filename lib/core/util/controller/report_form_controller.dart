import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:validators/validators.dart';

class ReportFormController {
  String? handleReportForm(
      BuildContext context, String fieldName, String value) {
    switch (fieldName) {
      case 'firstName':
        if (value.isEmpty) {
          return "First name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;
      case 'middleName':
        if (value.isEmpty) {
          return "Middle name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;
      case 'lastName':
        if (value.isEmpty) {
          return "Last name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name only in letters allowed";
        }
        break;

      default:
        return null;
    }

    return null;
  }

  String? handleVideoLink(
      BuildContext context, String fieldName, String value) {
    switch (fieldName) {
      case 'videoMessage':
        if (!isURL(value) ||
            !(value.contains('youtube.com') ||
                value.contains('youtu.be') ||
                value.contains('facebook.com') ||
                value.contains('instagram.com') ||
                value.contains('tiktok.com'))) {
          return "Please Enter a valid social media video link";
        }
        break;

      default:
        return null;
    }

    return null;
  }
}
