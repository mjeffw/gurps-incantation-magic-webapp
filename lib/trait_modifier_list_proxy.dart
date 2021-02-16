import 'dart:collection';

import 'package:gurps_dart/gurps_dart.dart';

class TraitModifierProxy extends TraitModifier {
  TraitModifierProxy({this.list, this.index});

  final TraitModifierListProxy list;
  final int index;

  @override
  String get name => list[index].name;

  @override
  int get percent => list[index].percent;

  set name(value) {
    list.update(index: index, name: value);
  }

  set percent(value) {
    list.update(index: index, percent: value);
  }
}

class TraitModifierListProxy extends Object with ListMixin<TraitModifierProxy> {
  TraitModifierListProxy({List<TraitModifier> source}) : _source = source ?? [];

  final List<TraitModifier> _source;

  @override
  int get length => _source.length;

  @override
  set length(int length) => _source.length = length;

  @override
  TraitModifierProxy operator [](int index) {
    return TraitModifierProxy(list: this, index: index);
  }

  @override
  TraitModifierProxy removeAt(int index) {
    TraitModifierProxy proxy = this[index];
    _source.removeAt(index);
    return proxy;
  }

  @override
  void operator []=(int index, TraitModifierProxy value) {}

  void addProxy() {
    _source.add(TraitModifier());
  }

  void update({int index, String name, String detail, int percent}) {
    _source[index] = TraitModifier(
      name: name ?? _source[index].name,
      detail: detail ?? _source[index].detail,
      percent: percent ?? _source[index].percent,
    );
  }
}
