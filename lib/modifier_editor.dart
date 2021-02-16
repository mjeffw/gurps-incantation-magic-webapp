import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

import 'traitmodifier_list_editor.dart';

@Component(
  selector: 'mjw-modifier-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[
    coreDirectives,
    materialDirectives,
    materialInputDirectives,
    MaterialNumberValueAccessor,
    TraitModifierListEditor
  ],
  templateUrl: 'modifier_editor.html',
  providers: const <dynamic>[materialProviders],
)
class ModifierEditor extends TextModifierExporter implements DoCheck {
  @Input()
  List<RitualModifier> ritualModifiers;

  @Input()
  int index;

  RitualModifier _modifier;
  RitualModifier get modifier => _modifier;

  @Input()
  set modifier(RitualModifier modifier) {
    _modifier = modifier;
    properties.clear();

    if (modifier is AlteredTraits) {
      properties[_modifier] =
          new AlteredTraitsAdapter(_modifier as AlteredTraits);
    } else if (modifier is AreaOfEffect) {
      properties[_modifier] =
          new AreaOfEffectAdapter(_modifier as AreaOfEffect);
    } else if (modifier is Bestows) {
      properties[_modifier] = new BestowsAdapter(_modifier as Bestows);
    } else if (modifier is Damage) {
      properties[_modifier] = new DamageAdapter(_modifier as Damage);
    }

    _modifier.export(this);
  }

  Map<RitualModifier, dynamic> properties = <RitualModifier, dynamic>{};

  void removeModifier() {
    ritualModifiers.removeAt(index);
  }

  @override
  void ngDoCheck() {
    TextModifierExporter exporter = new TextModifierExporter();
    _modifier.export(exporter);

    print(exporter.details[0].detailText);
    print(details[0].detailText);

    if ((exporter.details[0].detailText != details[0].detailText) ||
        (exporter.briefText != briefText)) {
      this.clear();
      _modifier.export(this);
    }
  }
}

class AlteredTraitsAdapter {
  AlteredTraitsAdapter(this._traits);
  AlteredTraits _traits;

  bool get hasLevels => _traits.trait.hasLevels;
  set hasLevels(bool b) => _traits.trait.hasLevels = b;

  String get traitName => _traits.trait.name;
  set traitName(String n) => _traits.trait.name = n;

  int get baseCost => _traits.trait.baseCost;
  set baseCost(int x) => _traits.trait.baseCost = x;

  int get levels => _traits.trait.levels;
  set levels(int x) => _traits.trait.levels = x;

  int get costPerLevel => _traits.trait.costPerLevel;
  set costPerLevel(int x) => _traits.trait.costPerLevel = x;
}

class AreaOfEffectAdapter {
  AreaOfEffectAdapter(this._area);

  AreaOfEffect _area;
  void incrementTargets() {
    _area.targets++;
  }

  void decrementTargets() {
    _area.targets--;
  }

  bool get includes => _area.includes;
  set includes(bool value) {
    _area.includes = value;
  }
}

class BestowsAdapter {
  BestowsAdapter(this._modifier);

  final Map<BestowsRange, String> valueToString = {
    BestowsRange.broad: 'Broad',
    BestowsRange.moderate: "Moderate",
    BestowsRange.single: "Single"
  };

  SelectionOptions<BestowsRange> rangeList =
      new SelectionOptions.fromList(BestowsRange.values);

  Bestows _modifier;
  SelectionModel<BestowsRange> get selectionModel {
    SelectionModel<BestowsRange> model =
        new SelectionModel.single(selected: _modifier.range);
    model.selectionChanges.listen(onData);
    return model;
  }

  String render(BestowsRange value) => valueToString[value];

  void onData(List<SelectionChangeRecord<BestowsRange>> list) {
    list.forEach((r) => _modifier.range = r.added.first);
  }
}

class DamageAdapter {
  DamageAdapter(this._modifier);

  Damage _modifier;

  SelectionOptions<DamageType> typeList =
      new SelectionOptions.fromList(DamageType.types);

  SelectionModel<DamageType> get selectionModel {
    SelectionModel<DamageType> model =
        new SelectionModel.single(selected: _modifier.type);
    model.selectionChanges.listen(onData);
    return model;
  }

  void onData(List<SelectionChangeRecord<DamageType>> list) {
    list.forEach((r) => _modifier.type = r.added.first);
  }

  String render(DamageType value) => value.label;
}
