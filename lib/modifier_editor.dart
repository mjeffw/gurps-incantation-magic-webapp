import 'package:angular_components/angular_components.dart';
import 'package:angular/angular.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'package:ng_materialdesign_sandbox/traitmodifier_list_editor.dart';

@Component(
  selector: 'mjw-modifier-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[
    COMMON_DIRECTIVES,
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
    switch (modifier.runtimeType) {
      case AreaOfEffect:
        properties['areaOfEffectAdapter'] = new AreaOfEffectAdapter(_modifier as AreaOfEffect);
        break;
      case Bestows:
        properties['bestowsAdapter'] = new BestowsAdapter(_modifier as Bestows);
        break;
      case Damage:
        properties['damageAdapter'] = new DamageAdapter(_modifier as Damage);
    }
    _modifier.export(this);
  }

  Map<String, dynamic> properties = new Map<String, dynamic>();

  void removeModifier() {
    ritualModifiers.removeAt(index);
  }

  @override
  void ngDoCheck() {
    TextModifierExporter exporter = new TextModifierExporter();
    _modifier.export(exporter);

    if ((exporter.details[0].detailText != details[0].detailText) || (exporter.briefText != briefText)) {
      this.clear();
      _modifier.export(this);
    }
  }
}

class AreaOfEffectAdapter {
  AreaOfEffect _area;
  AreaOfEffectAdapter(this._area);

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
  final Map<BestowsRange, String> valueToString = {
    BestowsRange.broad: 'Broad',
    BestowsRange.moderate: "Moderate",
    BestowsRange.single: "Single"
  };

  SelectionOptions<BestowsRange> rangeList = new SelectionOptions.fromList(BestowsRange.values);

  Bestows _modifier;
  BestowsAdapter(this._modifier);

  SelectionModel<BestowsRange> get selectionModel {
    SelectionModel<BestowsRange> model = new SelectionModel.withList(selectedValues: [_modifier.range]);
    model.selectionChanges.listen(onData);
    return model;
  }

  String render(BestowsRange value) => valueToString[value];

  void onData(List<SelectionChangeRecord<BestowsRange>> list) {
    list.forEach((r) => _modifier.range = r.added.first);
  }
}

class DamageAdapter {
  Damage _modifier;

  DamageAdapter(this._modifier);

  SelectionOptions<DamageType> typeList = new SelectionOptions.fromList(DamageType.values);

  SelectionModel<DamageType> get selectionModel {
    SelectionModel<DamageType> model = new SelectionModel.withList(selectedValues: [_modifier.type]);
    model.selectionChanges.listen(onData);
    return model;
  }

  void onData(List<SelectionChangeRecord<DamageType>> list) {
    list.forEach((r) => _modifier.type = r.added.first);
  }

  String render(DamageType value) => damageTypeLabels[value];
}
