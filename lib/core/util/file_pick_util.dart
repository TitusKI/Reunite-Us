import 'package:file_picker/file_picker.dart';

Future<List<PlatformFile>?> pickMultipleFiles() async {
  print('picking files');
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.any,
  );
  print(result);
  if (result != null) {
    print(result.files.first);
    return result.files;
  } else {
    print(" No RESULTS");
    return null;
  }
}
