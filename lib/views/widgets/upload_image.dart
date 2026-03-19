import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";

class UploadImage extends StatefulWidget {
  final Function onFileAttached;

  const UploadImage(this.onFileAttached, {super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: Text("Location Image:")),
        ElevatedButton(onPressed: _pickFile, child: const Text("Pick a file")),
        if (_selectedFile != null) ...[
          const SizedBox(height: 12),
          Text("Selected: ${_selectedFile!.name}"),
        ],
      ],
    );
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result == null) {
      return;
    }

    setState(() {
      _selectedFile = result.files.first;
    });

    widget.onFileAttached(_selectedFile);
  }
}
