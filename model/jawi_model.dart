class JawiModel {
  JawiModel(
      {required this.imagePath,
      required this.audioPath,
      required this.huruf});

  final String audioPath;
  final String huruf;
  final String imagePath;
}

class JawiRecognizer {
  List<JawiModel> alphabetList = [
    JawiModel(
        imagePath: 'asset/images/Alif.png',
        audioPath: 'audio/Alif.mp3',
        huruf: "Alif"),
    JawiModel(
        imagePath: 'asset/images/Ba.png',
        audioPath: 'audio/Ba.mp3',
        huruf: "Ba"),
    JawiModel(
        imagePath: 'asset/images/Ta.png',
        audioPath: 'audio/Ta.mp3',
        huruf: "Ta"),
    JawiModel(
        imagePath: 'asset/images/Sa.png',
        audioPath: 'audio/Sa.mp3',
        huruf: "Sa"),
    JawiModel(
        imagePath: 'asset/images/Jim.png',
        audioPath: 'audio/Jim.mp3',
        huruf: "Jim"),
    JawiModel(
        imagePath: 'asset/images/Ha.png',
        audioPath: 'audio/Ha.mp3',
        huruf: "Ha"),
    JawiModel(
        imagePath: 'asset/images/Kho.png',
        audioPath: 'audio/Kho.mp3',
        huruf: "Kho"),
    JawiModel(
        imagePath: 'asset/images/Dal.png',
        audioPath: 'audio/Dal.mp3',
        huruf: "Dal"),
    JawiModel(
        imagePath: 'asset/images/Dzal.png',
        audioPath: 'audio/Dzal.mp3',
        huruf: "Dzal"),
    JawiModel(
        imagePath: 'asset/images/Ra.png',
        audioPath: 'audio/Ra.mp3',
        huruf: "Ra"),
    JawiModel(
        imagePath: 'asset/images/Zai.png',
        audioPath: 'audio/Zai.mp3',
        huruf: "Zai"),
    JawiModel(
        imagePath: 'asset/images/Sin.png',
        audioPath: 'audio/Sin.mp3',
        huruf: "Sin"),
    JawiModel(
        imagePath: 'asset/images/Shin.png',
        audioPath: 'audio/Shin.mp3',
        huruf: "Shin"),
    JawiModel(
        imagePath: 'asset/images/Sod.PNG',
        audioPath: 'audio/Sod.mp3',
        huruf: "Sod"),
    JawiModel(
        imagePath: 'asset/images/Dhod.PNG',
        audioPath: 'audio/Dhod.mp3',
        huruf: "Dhod"),
    JawiModel(
        imagePath: 'asset/images/Tho.png',
        audioPath: 'audio/Tho.mp3',
        huruf: "Tho"),
    JawiModel(
        imagePath: 'asset/images/Dzo.PNG',
        audioPath: 'audio/Dzo.mp3',
        huruf: "Dzo"),
    JawiModel(
        imagePath: 'asset/images/Ain.png',
        audioPath: 'audio/Ain.mp3',
        huruf: "Ain"),
    JawiModel(
        imagePath: 'asset/images/Ghain.png',
        audioPath: 'audio/Ghain.mp3',
        huruf: "Ghain"),
    JawiModel(
        imagePath: 'asset/images/Fa.png',
        audioPath: 'audio/Fa.mp3',
        huruf: "Fa"),
    JawiModel(
        imagePath: 'asset/images/Qaf.png',
        audioPath: 'audio/Qaf.mp3',
        huruf: "Qaf"),
    JawiModel(
        imagePath: 'asset/images/Kaf.png',
        audioPath: 'audio/Kaf.mp3',
        huruf: "Kaf"),
    JawiModel(
        imagePath: 'asset/images/Lam.png',
        audioPath: 'audio/Lam.mp3',
        huruf: "Lam"),
    JawiModel(
        imagePath: 'asset/images/Mim.png',
        audioPath: 'audio/Mim.mp3',
        huruf: "Mim"),
    JawiModel(
        imagePath: 'asset/images/Nun.png',
        audioPath: 'audio/Nun.mp3',
        huruf: "Nun"),
    JawiModel(
        imagePath: 'asset/images/Wau.png',
        audioPath: 'audio/Wau.mp3',
        huruf: "Wau"),
    JawiModel(
        imagePath: 'asset/images/Haa.png',
        audioPath: 'audio/Haa.mp3',
        huruf: "Haa"),
    JawiModel(
        imagePath: 'asset/images/Hamzah.PNG',
        audioPath: 'audio/Hamzah.mp3',
        huruf: "Hamzah"),
    JawiModel(
        imagePath: 'asset/images/Ya.png',
        audioPath: 'audio/Ya.mp3',
        huruf: "Ya")
  ];
}
