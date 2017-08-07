// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'effect_editor_component.dart';
import 'modifier_editor_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const <dynamic>[CORE_DIRECTIVES, materialDirectives, SpellEffectEditorComponent, ModifierEditorComponent],
  providers: const <dynamic>[materialProviders],
)
class AppComponent {
  Spell _spell;

  Spell createSpell() {
    _spell = new Spell();
    String _description =
        "This spell imposes a magical compulsion on the target (who resists at -2), forcing him to obey all the "
        "caster's commands for an hour. The target cannot go against a direct command, but may interpret "
        "commands creatively. This spell doesn't provide any special means of communication or understanding of "
        "commands. If the subject is ordered to do something suicidal or radically against his nature (e.g., "
        "attack a co-religionist to whom he has a Sense of Duty) he gets a roll to resist that command by "
        "rolling Will vs. the caster's effective skill. The caster may not repeat a resisted order, even "
        "rephrased, if the outcome would be similar! Different orders are still possible; e.g., if \"Throw your "
        "friend in the lava\" fails, \"Make your friend leave\" may still work, so long as leaving doesn't require "
        "a lava-swim.";
    spell.name = 'Bond of Servitude for (Demons)';
    spell.addEffect(new SpellEffect(Effect.Control, Path.Demonology));
    spell.addRitualModifier(
        new Bestows("Resistance to Bond of Servitude", range: BestowsRange.single, value: -2, inherent: true));
    spell.addRitualModifier(new DurationMod(value: new GurpsDuration(hours: 1).inSeconds));
    spell.addRitualModifier(new Range(value: 20));
    spell.description = _description;
    return spell;
  }

  Spell get spell {
    if (_spell == null) {
      print('createSpell');
      _spell = createSpell();
    }
    return _spell;
  }

  void addModifier() {
  }

  void removeModifier(int index) {
    spell.ritualModifiers.removeAt(index);
  }
}
