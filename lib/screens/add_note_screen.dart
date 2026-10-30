import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String? _selectedCategory;
  int _selectedColorIndex = 0;
  String _selectedPriority = 'Sedang';

  final List<String> _categories = [
    'Ide',
    'Kerja',
    'Kuliah',
    'Pribadi',
    'Belanja',
    'Harian',
  ];

  final List<String> _priorities = [
    'Rendah',
    'Sedang',
    'Tinggi',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String _getCategoryIcon(String? category) {
    switch (category) {
      case 'Ide':
        return '💡';
      case 'Kerja':
        return '📅';
      case 'Kuliah':
        return '📖';
      case 'Belanja':
        return '🛒';
      case 'Harian':
        return '💙';
      case 'Pribadi':
      default:
        return '📝';
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul catatan tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final category = _selectedCategory ?? 'Ide';
    final now = DateTime.now();
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final newNote = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content.isEmpty ? 'Tidak ada isi catatan.' : content,
      date: dateStr,
      time: timeStr,
      category: category,
      icon: _getCategoryIcon(category),
      priority: _selectedPriority,
      cardColor: AppColors.pastelColors[_selectedColorIndex],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan berhasil ditambahkan! 🎉'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pop(newNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Tambah Catatan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Catatan
            const Text(
              'Judul Catatan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Masukkan judul catatan',
                fillColor: Color(0xFFF8FAF9),
              ),
            ),

            const SizedBox(height: 20),

            // Isi Catatan
            const Text(
              'Isi Catatan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Tulis catatanmu di sini...',
                fillColor: Color(0xFFF8FAF9),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 20),

            // Kategori
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAF9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  hint: const Text(
                    'Pilih kategori',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                  items: _categories.map((String cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Row(
                        children: [
                          Text(_getCategoryIcon(cat),
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Text(cat, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedCategory = val;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Warna
            const Text(
              'Warna',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(AppColors.pastelColors.length, (index) {
                final color = AppColors.pastelColors[index];
                final isSelected = _selectedColorIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.black.withValues(alpha: 0.08),
                        width: isSelected ? 2.5 : 1,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            size: 20,
                            color: AppColors.primaryDark,
                          )
                        : null,
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Prioritas
            const Text(
              'Prioritas',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: _priorities.map((priority) {
                final isSelected = _selectedPriority == priority;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFFF8FAF9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            priority,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 36),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 2,
                  shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
