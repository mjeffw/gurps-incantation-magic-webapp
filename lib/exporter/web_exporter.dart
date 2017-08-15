import 'package:gurps_incantation_magic_model/gurps/trait_modifier.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

//class WebSpellExporter implements SpellExporter {
//}

class WebModifierExporter extends TextModifierExporter {
  WebModifierDetail detail;

  @override
  void addDetail(ModifierDetail detail) {
    this.detail = detail as WebModifierDetail;
  }

  @override
  ModifierDetail createAfflictionDetail() => new WebAfflictionDetail();

  @override
  ModifierDetail createAfflictionStunDetail() => new WebAfflictionStunDetail();

  @override
  ModifierDetail createAlteredTraitsDetail() => new WebAlteredTraitsDetail();

  @override
  ModifierDetail createAreaEffectDetail() => new AreaOfEffectModifierDetail();

  @override
  ModifierDetail createBestowsDetail() => new BestowsModifierDetail();

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
  ModifierDetail createRangeTimeDetail() => new RangeTimeModifierDetail();

  // TODO: implement details
  @override
  ModifierDetail createRepairDetail() => null;

  @override
  ModifierDetail createSpeedDetail() => new SpeedModifierDetail();

  @override
  ModifierDetail createSubjectWeightDetail() => new WeightModifierDetail();

  @override
  ModifierDetail createSummonedDetail() => new SummonedModifierDetail();
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

class WebAfflictionStunDetail extends WebModifierDetail {
  // TODO: implement typicalText
  @override
  String get typicalText => "";
}

class WebAfflictionDetail extends WebModifierDetail implements AfflictionDetail {
  @override
  String specialization;

  @override
  String type = 'Afflictions';

  @override
  String get typicalText => '${name}, ${specialization} (${value}%)';
}

class WebAlteredTraitsDetail extends WebModifierDetail implements AlteredTraitsDetail {
  @override
  int specLevel;

  @override
  String specialization;

  List<TraitModifier> modifiers = [];

  @override
  void addModifier(TraitModifier it) => modifiers.add(it);

  @override
  String get typicalText {
    String temp = '${name}, ${specialization}';
    if (specLevel != null && specLevel != 0) {
      temp += ' ${specLevel}';
    }
    if (modifiers.isNotEmpty) {
      temp += ' (${modifiers.map((e) => e.typicalText).join('; ')})';
    }
    return temp;
  }
}

class AreaOfEffectModifierDetail extends WebModifierDetail implements AreaOfEffectDetail {
  @override
  bool includes;

  @override
  int targets;

  @override
  String get typicalText => 'Area of Effect, ${value} yards, ${includes ? "including" : "excluding"} ${targets} targets';
}

class BestowsModifierDetail extends WebModifierDetail implements BestowsDetail {
  @override
  String get typicalText =>
      'Bestows a ${value < 0 ? "Penalty" : "Bonus"}, ${value < 0 ? "-" : "+"}${value.abs()} to ${specialization}';
  @override
  String range;

  @override
  String specialization;
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
  String get typicalText => "${GurpsDistance.toFormattedString(value, showFraction: true)}";
}

class RangeDimensionalModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${value} dimension${value > 1 ? 's' : ''}";
}

class RangeInformationalModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => (value == 880) ? '1/2 mile' : GurpsDistance.toFormattedString(value);
}

class RangeTimeModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => (value < 24) ? '${value} hours' : '${value ~/ 24} days';
}

//class RepairModifierDetail extends WebModifierDetail {
//  @override
//  String get typicalText => '${new DieRoll(1, value).toString()}';
//}

class SpeedModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${GurpsDistance.toFormattedString(value, showFraction: true)}/second";
}

class SummonedModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => "${value}% of Static Point Total";
}

class WeightModifierDetail extends WebModifierDetail {
  @override
  String get typicalText => Weight.toFormattedString(value);
}
