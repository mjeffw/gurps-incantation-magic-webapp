import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

@Component(
  selector: 'mjw-spell-text',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[],
  template: '''
  <h3><i>{{name}}</i></h3>
  <div>
  <p style="padding-left: 24px;">
  <i>Spell Effects:</i> {{effectExporter.briefText}}.<br/>
  <i>Inherent Modifiers:</i> {{modifierExporter.briefText}}.<br/> 
  <i>Skill Penalty:</i> {{penaltyPath}}.<br/>
  <i>Casting Time:</i> {{castingTime}}.<br/>
  </p> 
  <p style="text-indent: 24px;">
  {{description}}
  </p>
  <p style="text-indent: 24px;">
  <i>Typical Casting: </i> {{typical}}. {{spellPoints}} SP.
  </p>
  </div>
  ''',
  providers: const <dynamic>[coreDirectives, materialProviders],
)
class SpellText extends TextSpellExporter implements DoCheck {
  Spell _spell;

  @Input()
  set spell(Spell spell) {
    _spell = spell;
    _spell.export(this);
  }

  @override
  void ngDoCheck() {
    TextSpellExporter exporter = new TextSpellExporter();
    _spell.export(exporter);

    if ((exporter.description != description) ||
        (exporter.typical != typical) ||
        (exporter.effectExporter.briefText != effectExporter.briefText) ||
        (exporter.modifierExporter.briefText != modifierExporter.briefText) ||
        (exporter.castingTime != castingTime) ||
        (exporter.name != name)) {
      _spell.export(this);
    }
  }
}
