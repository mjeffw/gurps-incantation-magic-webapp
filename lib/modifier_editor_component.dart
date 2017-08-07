import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'exporter/web_exporter.dart';

@Component(
  selector: 'simple-modifier-editor',
  styleUrls: const ['app_component.css'],
  directives: const <dynamic>[COMMON_DIRECTIVES, materialDirectives, materialInputDirectives],
  templateUrl: 'modifier_editor_component.html',
  providers: const <dynamic>[materialProviders],
)
class ModifierEditorComponent {
  @Input()
  Spell spell;

  @Input()
  int index;

  RitualModifier _modifier;

  Map<String, dynamic> properties = new Map<String, dynamic>();

  RitualModifier get modifier => _modifier;

  @Input()
  set modifier(RitualModifier modifier) {
    _modifier = modifier;
    if (modifier is Bestows) {
      properties['bestowsSelections'] = new BestowsSelections(_modifier as Bestows);
    }
  }

  void removeModifier() {
    spell.ritualModifiers.removeAt(index);
  }

  String get typicalText {
    WebModifierExporter exporter = new WebModifierExporter();
    _modifier.export(exporter);
    return exporter.detail.typicalText;
  }
}

class BestowsSelections {
  final Map<BestowsRange, String> valueToString = {
    BestowsRange.broad: 'Broad',
    BestowsRange.moderate: "Moderate",
    BestowsRange.single: "Single"
  };

  SelectionOptions<BestowsRange> rangeList = new SelectionOptions.fromList(BestowsRange.values);

  Bestows _modifier;
  BestowsSelections(this._modifier);

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
