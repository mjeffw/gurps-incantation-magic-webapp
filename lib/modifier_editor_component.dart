import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'exporter/web_exporter.dart';

@Component(
  selector: 'simple-modifier-editor',
  styleUrls: const ['app_component.css'],
  directives: const [COMMON_DIRECTIVES, materialDirectives], // ignore: strong_mode_implicit_dynamic_list_literal
  templateUrl: 'modifier_editor_component.html',
  providers: const [materialProviders], // ignore: strong_mode_implicit_dynamic_list_literal
)
class ModifierEditorComponent {
  @Input()
  Spell spell;

  @Input()
  int index;

  RitualModifier _modifier;
  WebModifierExporter exporter = new WebModifierExporter();
  //  ModifierDetail detail = new WebModifierDetail();

  @Input()
  set modifier(RitualModifier mod) {
    _modifier = mod;
    _modifier.export(exporter);
  }

  void removeModifier() {
    spell.ritualModifiers.removeAt(index);
  }

  void incrementValue() {
    _modifier.incrementSpellPoints();
    _modifier.export(exporter);
  }

  void decrementValue() {
    _modifier.decrementSpellPoints();
    _modifier.export(exporter);
  }

  bool get inherent => exporter.detail.inherent;

  set inherent(bool value) {
    _modifier.inherent = value;
    _modifier.export(exporter);
  }
}
