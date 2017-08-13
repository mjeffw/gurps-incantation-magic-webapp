// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'effect_editor_component.dart';
import 'modifier_editor_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components
typedef RitualModifier Creator();

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
    String _description = "You create a mystical 'booby-trap,' akin to cans strung along a wire, in a "
        "five-yard radius from the starting point. When an unauthorized being (you may "
        "authorize up to six) enters the area, every authorized being automatically "
        "wakes up (if asleep) and becomes aware of the invasion. Mundane stealth cannot "
        "overcome this; resolve any supernatural attempts at stealth as a Quick Contest "
        "against the incanter's Path of Arcanum. This is a conditional spell (p. 20) "
        "that 'hangs' until triggered or until everyone wakes up for the day.";

    _spell.name = "Alarm";
    _spell.conditional = true;
    _spell.effects.add(new SpellEffect(Effect.Create, Path.Arcanum));
    AreaOfEffect m = new AreaOfEffect(value: 5, inherent: true)..setTargetInfo(6, true);
    _spell.ritualModifiers.add(m);
    _spell.ritualModifiers.add(new Bestows("Rolls to resist", value: 2, range: BestowsRange.single));
    _spell.ritualModifiers.add(new SubjectWeight(value: 300));
    _spell.description = _description;
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
