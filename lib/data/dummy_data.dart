import '../models/note_model.dart';
import '../theme/app_theme.dart';

class DummyData {
  static List<NoteModel> initialNotes = [
    NoteModel(
      id: '1',
      title: 'Ide Aplikasi',
      content:
          'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas. Aplikasi ini digunakan untuk mencatat ide, rencana, dan hal penting sehari-hari.',
      date: '28 Oktober 2026',
      time: '09:30',
      category: 'Ide',
      icon: '💡',
      priority: 'Penting',
      cardColor: AppColors.pastelColors[0],
    ),
    NoteModel(
      id: '2',
      title: 'Rencana Mingguan',
      content:
          '1. Menyelesaikan perancangan UI Flutter.\n2. Review progres tugas akhir kelompok.\n3. Olahraga pagi setiap Selasa dan Kamis.\n4. Membaca 1 bab buku produktivitas.',
      date: '28 Oktober 2026',
      time: '14:00',
      category: 'Kerja',
      icon: '📅',
      priority: 'Sedang',
      cardColor: AppColors.pastelColors[1],
    ),
    NoteModel(
      id: '3',
      title: 'Catatan Kuliah',
      content:
          'Materi Pemrograman Mobile: Pengenalan Flutter Widget Tree, Stateful vs Stateless, State Management, dan responsive layout di Android/iOS.',
      date: '27 Oktober 2026',
      time: '10:15',
      category: 'Kuliah',
      icon: '📖',
      priority: 'Sedang',
      cardColor: AppColors.pastelColors[2],
    ),
    NoteModel(
      id: '4',
      title: 'Hal yang Perlu Dibeli',
      content:
          '• Binder kertas A5\n• Pulpen gel 0.5mm hitam\n• Biji kopi arabika\n• Sticky notes pastel\n• Flashdisk 64GB',
      date: '26 Oktober 2026',
      time: '19:45',
      category: 'Pribadi',
      icon: '🛒',
      priority: 'Rendah',
      cardColor: AppColors.pastelColors[3],
    ),
    NoteModel(
      id: '5',
      title: 'Jurnal Harian',
      content:
          'Hari ini belajar banyak hal baru mengenai antarmuka pengguna Flutter. Sangat menyenangkan melihat hasil desain UI yang rapi, modern, dan konsisten.',
      date: '25 Oktober 2026',
      time: '21:00',
      category: 'Pribadi',
      icon: '💙',
      priority: 'Rendah',
      cardColor: AppColors.pastelColors[4],
    ),
  ];
}

