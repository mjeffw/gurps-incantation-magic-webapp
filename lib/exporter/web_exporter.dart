import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'package:angular_components/angular_components.dart';

//class WebSpellExporter implements SpellExporter {
//}

class WebModifierExporter implements ModifierExporter {
  WebModifierDetail detail;

  @override
  void addDetail(ModifierDetail detail) {
    this.detail = detail as WebModifierDetail;
  }

  // TODO: implement details
  @override
  List<ModifierDetail> get details => null;

  // TODO: implement typicalText
  @override
  String get typicalText => null;

  RitualModifier _modifier;
  set modifier(RitualModifier modifier) => _modifier = modifier;

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
  ModifierDetail createBestowsDetail() => new BestowsModifierDetail(this);

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

class WebAfflictionDetail extends WebModifierDetail implements AfflictionDetail {
  String specialization;

  @override
  String type = 'Affliction';

  @override
  String get typicalText => '${name}, ${specialization} (${value}%)';
}

class BestowsModifierDetail extends WebModifierDetail implements BestowsDetail {
  static Map<String, BestowsRange> BestowsValueMap = {
    'Broad': BestowsRange.broad,
    'Moderate': BestowsRange.moderate,
    'Single': BestowsRange.single
  };

  @override
  String type = 'Bonus';

  @override
  String specialization;

  @override
  String range;

  WebModifierExporter _webModifierExporter;
  BestowsModifierDetail(this._webModifierExporter);

  @override
  String get typicalText =>
      'Bestows a ${value < 0 ? "Penalty" : "Bonus"}, ${value < 0 ? "-" : "+"}${value.abs()} to ${specialization}';

  SelectionOptions<String> rangeList = new SelectionOptions.fromList(BestowsValueMap.keys.toList(growable: false));

  // TODO must delegate changes to selection to _webModifierExporter._modifier
  SelectionModel<BestowsRange> selectModel = new SelectionModel.withList();
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
