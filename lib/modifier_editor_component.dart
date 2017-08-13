import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'exporter/web_exporter.dart';

@Component(
  selector: 'modifier-editor',
  styleUrls: const ['app_component.css'],
  directives: const <dynamic>[COMMON_DIRECTIVES, materialDirectives, materialInputDirectives, MaterialNumberValueAccessor],
  templateUrl: 'modifier_editor_component.html',
  providers: const <dynamic>[materialProviders],

)
class ModifierEditorComponent implements OnChanges {
  @Input()
  Spell spell;

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
        properties['areaOfEffectAdapter'] = new AreaOfEffectAdapter(_modifier as AreaOfEffect, this);
        break;
      case Bestows:
        properties['bestowsAdapter'] = new BestowsAdapter(_modifier as Bestows);
        break;
    }
    _modifier.export(exporter);
  }

  WebModifierExporter exporter = new WebModifierExporter();
  Map<String, dynamic> properties = new Map<String, dynamic>();

  void removeModifier() {
    spell.ritualModifiers.removeAt(index);
  }

  String get typicalText {
    _modifier.export(exporter);
    return exporter.detail.typicalText;
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    changes.forEach((key, value) => print('${key} : ${value.previousValue} > ${value.currentValue}'));
  }
}

class AreaOfEffectAdapter {
  AreaOfEffect _area;
  ModifierEditorComponent _component;
  AreaOfEffectAdapter(this._area, this._component);

  void incrementTargets() { _area.targets++; }
  void decrementTargets() { _area.targets--; }

  bool get includes => _area.includes;
  set includes(bool value) {
    _area.includes = value;
    _area.export(_component.exporter);
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
