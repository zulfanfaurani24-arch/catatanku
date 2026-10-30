import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';
import '../widgets/note_card.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<NoteModel> _notes;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  int _currentBottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Semua',
    'Penting',
    'Pribadi',
    'Kerja',
    'Kuliah',
  ];

  @override
  void initState() {
    super.initState();
    _notes = List.from(DummyData.initialNotes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<NoteModel> get _filteredNotes {
    return _notes.where((note) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          (_selectedCategory == 'Penting' &&
              (note.priority == 'Penting' || note.priority == 'Tinggi')) ||
          note.category.toLowerCase() == _selectedCategory.toLowerCase();

      final matchesSearch = _searchQuery.isEmpty ||
          note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _navigateToAddNote() async {
    final newNote = await Navigator.of(context).push<NoteModel>(
      MaterialPageRoute(
        builder: (context) => const AddNoteScreen(),
      ),
    );

    if (newNote != null) {
      setState(() {
        _notes.insert(0, newNote);
      });
    }
  }

  void _navigateToDetail(NoteModel note) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (context) => NoteDetailScreen(note: note),
      ),
    );

    if (result != null) {
      if (result['action'] == 'delete') {
        setState(() {
          _notes.removeWhere((item) => item.id == note.id);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Catatan berhasil dihapus'),
              backgroundColor: AppColors.textPrimary,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else if (result['action'] == 'update' && result['note'] != null) {
        final updatedNote = result['note'] as NoteModel;
        setState(() {
          final index = _notes.indexWhere((item) => item.id == updatedNote.id);
          if (index != -1) {
            _notes[index] = updatedNote;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar / User Greeting
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Text(
                            'Halo, Zulfan',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF064E3B),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Apa yang ingin kamu catat hari ini?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  // Avatar
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryUltraLight,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Z',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari catatan...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Category Filter Chips
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(cat),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary,
                      showCheckmark: false,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFFE2E8F0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // Note List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 64,
                            color: AppColors.textMuted.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Tidak ada catatan ditemukan',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Coba ganti kata kunci pencarian atau kategori',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final note = filtered[index];
                        return NoteCard(
                          note: note,
                          onTap: () => _navigateToDetail(note),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Floating Action Button Tambah Catatan
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNote,
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_rounded,
                  label: 'Beranda',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.folder_outlined,
                  label: 'Arsip',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.person_outline_rounded,
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentBottomNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentBottomNavIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
