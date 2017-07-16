import 'package:gurps_incantation_magic_model/incantation_magic.dart';

//class WebSpellExporter implements SpellExporter {
//}

class WebModifierExporter implements ModifierExporter {
  WebModifierDetail detail;

  @override
  void addDetail(ModifierDetail detail) {
    this.detail = detail as WebModifierDetail;
  }

  @override
  ModifierDetail createAfflictionDetail() => new WebAfflictionDetail();

  @override
  ModifierDetail createAfflictionStunDetail() {
    // TODO: implement createAlteredTraitsDetail
  }

  @override
  ModifierDetail createAlteredTraitsDetail() {
    // TODO: implement createAlteredTraitsDetail
  }

  @override
  ModifierDetail createAreaEffectDetail() {
    // TODO: implement createAreaEffectDetail
  }

  @override
  ModifierDetail createBestowsDetail() {
    // TODO: implement createBestowsDetail
  }

  @override
  ModifierDetail createDamageDetail() {
    // TODO: implement createDamageDetail
  }

  @override
  ModifierDetail createDurationDetail() => new DurationModifierDetail();

  @override
  ModifierDetail createGirdedDetail() {
    // TODO: implement createGirdedDetail
  }

  @override
  ModifierDetail createRangeDetail() {
    // TODO: implement createRangeDetail
  }

  @override
  ModifierDetail createRangeDimensionalDetail() {
    // TODO: implement createRangeDimensionalDetail
  }

  @override
  ModifierDetail createRangeInformationalDetail() {
    // TODO: implement createRangeInformationalDetail
  }

  @override
  ModifierDetail createRangeTimeDetail() {
    // TODO: implement createRangeTimeDetail
  }

  @override
  ModifierDetail createRepairDetail() {
    // TODO: implement createRepairDetail
  }

  @override
  ModifierDetail createSpeedDetail() {
    // TODO: implement createSpeedDetail
  }

  @override
  ModifierDetail createSubjectWeightDetail() => new WeightModifierDetail();

  @override
  ModifierDetail createSummonedDetail() {
    // TODO: implement createSummonedDetail
  }

  // TODO: implement details
  @override
  List<ModifierDetail> get details => null;

  // TODO: implement typicalText
  @override
  String get typicalText => null;
}

abstract class WebModifierDetail extends ModifierDetail {
  bool inherent;
  String type = 'Simple';
  String name;
  int spellPoints;
  int value;

  // TODO: implement summaryText
  @override
  String get summaryText => null;
}

class WebAfflictionDetail extends WebModifierDetail implements AfflictionDetail {
  String specialization;

  @override
  String get typicalText => '${name}, ${specialization} (${value}%)';
}

class DurationModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => (value == 0) ? "Momentary" : GurpsDuration.toFormattedString(value);
}

class WeightModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => Weight.toFormattedString(value);
}