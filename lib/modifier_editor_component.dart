import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'package:gurps_incantation_magic_model/units/gurps_duration.dart';

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
  ModifierDetail detail = new WebModifierDetail();

  @Input()
  set modifier(RitualModifier mod) {
    _modifier = mod;
    _modifier.exportDetail(detail);
  }

  void removeModifier() {
    spell.ritualModifiers.removeAt(index);
  }

  void incrementValue() {
    _modifier.incrementValue();
    _modifier.exportDetail(detail);
  }

  void decrementValue() {
    _modifier.decrementValue();
    _modifier.exportDetail(detail);
  }

  bool get inherent => (detail as WebModifierDetail).inherent;

  set inherent(bool value) {
    _modifier.inherent = value;
    _modifier.exportDetail(detail);
  }
}

class WebModifierDetail extends ModifierDetail {
  String type = 'Simple';
  String name;
  int spellPoints;
  bool inherent;
  GurpsDuration _duration;

  // TODO: implement summaryText
  @override
  String get summaryText => null;

  @override
  String get typicalText => _duration.toFormattedString();

  @override
  set value(int value) {
    _duration = new GurpsDuration(seconds: value);
  }
}
