// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'effectlist_editor.dart';
import 'modifier_editor.dart';
import 'spell_text.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components
typedef RitualModifier Creator();

@Component(
  selector: 'mjw-spell-editor',
  styleUrls: const ['spell_editor.css'],
  templateUrl: 'spell_editor.html',
  directives: const <dynamic>[CORE_DIRECTIVES, materialDirectives, EffectListEditor, ModifierEditor, SpellText],
  providers: const <dynamic>[materialProviders],
)
class SpellEditor {
  Spell _spell;

  Spell createSpell() {
    Spell spell = new Spell();
    String _description = "You create a mystical 'booby-trap,' akin to cans strung along a wire, in a "
        "five-yard radius from the starting point. When an unauthorized being (you may "
        "authorize up to six) enters the area, every authorized being automatically "
        "wakes up (if asleep) and becomes aware of the invasion. Mundane stealth cannot "
        "overcome this; resolve any supernatural attempts at stealth as a Quick Contest "
        "against the incanter's Path of Arcanum. This is a conditional spell (p. 20) "
        "that 'hangs' until triggered or until everyone wakes up for the day.";

    spell.name = "Alarm";
    spell.conditional = true;
    spell.effects.add(new SpellEffect(Effect.Create, Path.Arcanum));
    AreaOfEffect m = new AreaOfEffect(value: 5, inherent: true)..setTargetInfo(6, true);
    spell.ritualModifiers.add(m);
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
