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
  // ignore: strong_mode_implicit_dynamic_list_literal
  directives: const [CORE_DIRECTIVES, materialDirectives, SpellEffectEditorComponent, ModifierEditorComponent],
  providers: const [materialProviders], // ignore: strong_mode_implicit_dynamic_list_literal
)
class AppComponent {
  Spell _spell;

  Spell createSpell() {
    _spell = new Spell();
    String _description =
        "This spell holds the subject (who must have an IQ of 6 or higher) motionless and unaware of time's "
        "passage (treat as dazed, p. B428). The subject may roll against the better of HT or Will to 'shake "
        "off' the effect every (margin of loss) minutes. Otherwise, this lasts as long as the caster and the "
        "subject's eyes meet; if either one can no longer see the other's eyes, the spell is instantly broken. "
        "(The short casting time is due to this drawback; see Limited Spells, p. 15.) This is often cast as a "
        "'blocking' spell (p. 20) at the usual -10 to skill.";
    spell.name = 'Bewitchment';
    spell.addEffect(new SpellEffect(Effect.Destroy, Path.Mesmerism));
    spell.addDrawback("Requires eye contact", null, -40);
    spell.addRitualModifier(new Affliction("Daze", value: 50, inherent: true));
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
