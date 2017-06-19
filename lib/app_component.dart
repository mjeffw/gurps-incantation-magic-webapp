// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'package:ng_materialdesign_sandbox/spell_effect_editor_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, SpellEffectEditorComponent], // ignore: strong_mode_implicit_dynamic_list_literal
  providers: const [materialProviders],
)
class AppComponent {
  Spell _spell;

  Spell createSpell() {
    _spell = new Spell();
    String _description =
        'This spell gives any inanimate object the ability move, and to understand and follow simple commands. '
        'It has DX equal to your Path level-5, Move equal to Path/3 (round down), and ST/HP based on its weight '
        '(see p. B558). It has whatever skills (equal to your Path of Arcanum level) and advantages the GM '
        'thinks are appropriate to an object of its shape or purpose. For example, if a caster had Path of '
        'Arcanum-15 and he animated a 3 lb. broom, it might have ST/HP 12, DX 10, Move 5, and Housekeeping-15. '
        'Many casters will customize this spell, using Bestows a Bonus (p. 15) to give higher skills or '
        'attributes. Botches usually produce an animated object with creative and hostile intent!';
    spell.name = "Animate Object";
    spell.addEffect(new SpellEffect(Effect.Create, Path.Arcanum));
    spell.addEffect(new SpellEffect(Effect.Control, Path.Arcanum));
    spell.addRitualModifier(new DurationMod(value: new GurpsDuration(hours: 12).inSeconds));
    spell.addRitualModifier(new SubjectWeight(value: 100));
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

  void addModifier() {}

  List<ModifierDetail> get modifierDetails => _spell.export(new TextSpellExporter()).modifierExporter.details;
}
