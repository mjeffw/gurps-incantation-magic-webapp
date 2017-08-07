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

  @Input()
  RitualModifier modifier;


  void removeModifier() {
    spell.ritualModifiers.removeAt(index);
  }

  String get typicalText {
    WebModifierExporter exporter = new WebModifierExporter();
    modifier.export(exporter);
    return exporter.detail.typicalText;
  }
}
