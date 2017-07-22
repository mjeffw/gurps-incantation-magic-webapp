import 'package:gurps_incantation_magic_model/incantation_magic.dart';

//class WebSpellExporter implements SpellExporter {
//}

class WebModifierExporter implements ModifierExporter {
  WebModifierDetail detail;

  @override
  void addDetail(ModifierDetail detail) {
    this.detail = detail as WebModifierDetail;
  }

  // TODO: implement createAlteredTraitsDetail
  @override
  ModifierDetail createAfflictionDetail() => null;

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
  ModifierDetail createGirdedDetail() => new GirdedModifierDetail();

  @override
  ModifierDetail createRangeDetail() => new RangeModifierDetail();

  @override
  ModifierDetail createRangeDimensionalDetail() => new RangeDimensionalModifierDetail();

  @override
  ModifierDetail createRangeInformationalDetail() => new RangeInformationalModifierDetail();

  @override
  ModifierDetail createRangeTimeDetail() {
    // TODO: implement createRangeTimeDetail
  }

  @override
  ModifierDetail createRepairDetail() {
    // TODO: implement createRepairDetail
  }

  @override
  ModifierDetail createSpeedDetail() => new SpeedModifierDetail();

  @override
  ModifierDetail createSubjectWeightDetail() => new WeightModifierDetail();

  @override
  ModifierDetail createSummonedDetail() => new SummonedModifierDetail();

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

class GirdedModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => '${value} spell points';
}

class RangeModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${value} yards";
}

class RangeDimensionalModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${value} dimension${value > 1 ? 's' : ''}";
}

class RangeInformationalModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => GurpsDistance.toFormattedString(value);
}

class SpeedModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${GurpsDistance.toFormattedString(value)} yards per second";
}

class SummonedModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${value}% of Static Point Total";
}

class WeightModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => Weight.toFormattedString(value);
}
