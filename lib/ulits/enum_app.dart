enum SeatsType {
  firtClass,
  businessClass,
  economyClass;

  String get value => switch (this) {
        firtClass => 'firtClass',
        businessClass => 'businessClass',
        economyClass => 'economyClass',
      };
}
