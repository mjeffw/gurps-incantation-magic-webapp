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
    spell.name = 'Scry';
    spell.addEffect(new SpellEffect(Effect.Strengthen, Path.Augury));
    spell.addRitualModifier(new Speed(value: 20000, inherent: true));
    spell.addRitualModifier(new DurationMod(value: 10800));
    spell.addRitualModifier(new RangeInformational(value: 200000));
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
