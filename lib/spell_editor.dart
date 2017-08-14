// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'effectlist_editor.dart';
import 'modifier_editor.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components
typedef RitualModifier Creator();

@Component(
  selector: 'mjw-spell-editor',
  styleUrls: const ['spell_editor.css'],
  templateUrl: 'spell_editor.html',
  directives: const <dynamic>[CORE_DIRECTIVES, materialDirectives, SpellEffectEditorComponent, ModifierEditorComponent],
  providers: const <dynamic>[materialProviders],
)
class AppComponent {
  Spell _spell;

  Spell createSpell() {
    _spell = new Spell();
    String _description =
        "This spell grants the subject DR 6 with the Tough Skin and Hardened 2 modifiers. This protection lasts for "
        "12 minutes.";
    spell.name = 'Bulwark';
    spell.effects.add(new SpellEffect(Effect.Strengthen, Path.Protection));
    AlteredTraits alteredTraits = new AlteredTraits("Damage Resistance", 6, value: 30, inherent: true);
    alteredTraits.addModifier("Hardened 2", null, 40);
    alteredTraits.addModifier("Tough Skin", null, -40);
    spell.ritualModifiers.add(alteredTraits);
    spell.ritualModifiers.add(new DurationMod(value: new GurpsDuration(minutes: 12).inSeconds));
    spell.ritualModifiers.add(new SubjectWeight(value: 1000));
    spell.description = _description;
    _spell = spell;
    return _spell;
  }

  Spell get spell {
    if (_spell == null) {
      print('createSpell');
      _spell = createSpell();
    }
    return _spell;
  }

  bool showModifierDialog = false;

  final SelectionOptions<String> modifierOptions = new SelectionOptions.fromList(map.keys.toList(growable: false));

  static Map<String, Creator> map = {
    "Affliction": () => new Affliction(null),
    "Affliction (Stun)": () => new AfflictionStun(),
    "Altered Traits": () => new AlteredTraits(null, 0),
    "Area of Effect": () => new AreaOfEffect(),
    "Bestows a (Bonus or Penalty)": () => new Bestows(null),
    "Damage": () => new Damage(),
    "Duration": () => new DurationMod(),
    "Girded": () => new Girded(),
    "Range": () => new Range(),
    "Range (Cross-time)": () => new RangeCrossTime(),
    "Range (Extradimensional)": () => new RangeDimensional(),
    "Range (Informational)": () => new RangeInformational(),
    "Repair": () => new Repair(null),
    "Speed": () => new Speed(),
    "Subject Weight": () => new SubjectWeight(),
    "Summoned": () => new Summoned(),
  };

  final SelectionModel<String> modifierSelectModel =
      new SelectionModel.withList(selectedValues: [map.keys.toList(growable: false)[0]]);

  String get modifierSelectLabel => modifierSelectModel.selectedValues.first;

  void addModifier() {
    spell.ritualModifiers.add(map[modifierSelectLabel]());
    showModifierDialog = false;
  }

  void removeModifier(int index) {
    spell.ritualModifiers.removeAt(index);
  }
}
