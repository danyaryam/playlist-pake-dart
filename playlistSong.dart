import 'dart:collection';
import 'dart:io';

class Song {
  String title;
  String artist;

  Song(this.title, this.artist);

  @override
  String toString() {
    return '$title by $artist';
  }
}

class Node {
  Song song;
  Node? next;

  Node(this.song);
}

class LinkedList {
  Node? head;

  void append(Song song) {
    if (head == null) {
      head = Node(song);
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = Node(song);
    }
  }

  void display() {
    Node? current = head;
    while (current != null) {
      print(current.song);
      current = current.next;
    }
  }

  bool get isEmpty => head == null;

  int get length {
    int count = 0;
    Node? current = head;
    while (current != null) {
      count++;
      current = current.next;
    }
    return count;
  }

  Song operator [](int index) {
    int count = 0;
    Node? current = head;
    while (current != null) {
      if (count == index) {
        return current.song;
      }
      count++;
      current = current.next;
    }
    throw IndexError(index, this, 'Index out of range', null, length);
  }
}

class Playlist {
  Queue<Song> _queue = Queue<Song>();
  LinkedList _history = LinkedList();

  void addSong(Song song) {
    _queue.addLast(song);
    print('Menambahkan: $song');
  }

  void playNext() {
    if (_queue.isNotEmpty) {
      Song nextSong = _queue.removeFirst();
      _history.append(nextSong);
      print('Lagu dimainkan: $nextSong');
    } else {
      print('Tidak ada lagu dalam playlist musik');
    }
  }

  void showPlaylist() {
    if (_queue.isEmpty) {
      print('Playlist kosong.');
    } else {
      for (var i = 0; i < _queue.length; i++) {
        print('${i + 1}. ${_queue.elementAt(i)}');
      }
    }
  }

  void showHistory() {
    print('--- Riwayat Lagu yang Dimainkan ---');
    if (_history.isEmpty) {
      print('Belum ada lagu yang dimainkan.');
    } else {
      for (var i = 0; i < _history.length; i++) {
        print('${i + 1}. ${_history[i]}');
      }
    }
  }
}

void main() {
  Playlist playlist = Playlist();

  while (true) {
    print('======= Playlist Musik =======');
    print('| 1. Tambah lagu ke playlist |');
    print('| 2. Mainkan lagu berikutnya |');
    print('| 3. Tampilkan playlist      |');
    print('| 4. Tampilkan riwayat       |');
    print('| 5. Keluar                  |');
    print('==============================');
    stdout.write('Pilih opsi 1-5? ');
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write('Masukkan judul lagu: ');
        String title = stdin.readLineSync()!;
        stdout.write('Masukkan penyanyi: ');
        String artist = stdin.readLineSync()!;
        Song song = Song(title, artist);
        playlist.addSong(song);
        break;
      case 2:
        playlist.playNext();
        break;
      case 3:
        playlist.showPlaylist();
        break;
      case 4:
        playlist.showHistory();
        break;
      case 5:
        print('Keluar...');
        return;
      default:
        print('Pilihan tidak valid, coba lagi.');
    }
  }
}
