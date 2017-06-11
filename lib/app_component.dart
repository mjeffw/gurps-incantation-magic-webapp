// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  // ignore: strong_mode_implicit_dynamic_list_literal
  directives: const [CORE_DIRECTIVES, materialDirectives],
  // ignore: strong_mode_implicit_dynamic_list_literal
  providers: const [materialProviders],
)
class AppComponent {
  Spell _spell;

  Spell createSpell() {
    _spell = new Spell();
    String _description =
        "This spell summons a warrior simulacrum (below) to defend you for one hour. You may specify its combat "
        "skills when the spell is cast. (The two Create Arcanum effects are for its body and its independent "
        "spirit.) The warrior is a dedicated, fanatic guardian who will willingly lay down its life for its "
        "master. While it can be ordered to perform various unskilled tasks, it will refuse to be separated from "
        "its master, and will abandon all orders to rush to its master's defense. It has the attitude of a "
        "faithful but jealous dog; it does not understand the motivations of the living beyond 'survival,' and "
        "may mistake jokes and harmless social situations for aggression. The warrior is created without armor "
        "or weapons; these must be provided via another spell or given to it by hand.";
    _spell.name = 'Create Golem Warrior';
    _spell.addEffect(new SpellEffect(Effect.Create, Path.Arcanum));
    _spell.addEffect(new SpellEffect(Effect.Create, Path.Arcanum));
    _spell.addRitualModifier(new Summoned(value: 50, inherent: true));
    _spell.addRitualModifier(new DurationMod(value: new GurpsDuration(hours: 1).inSeconds));
    _spell.addRitualModifier(new SubjectWeight(value: 300));
    _spell.description = _description;
    return spell;
  }

  Spell get spell {
    if (_spell == null) {
      _spell = createSpell();
    }
    return _spell;
  }

  List<ModifierDetail> get modifierDetails => _spell.export(new TextSpellExporter()).modifierExporter.details;

  static List<String> effects = Effect.values.map((e) => e.name).toList();
  SelectionOptions<String> effectList = new SelectionOptions.fromList(effects);
  SelectionModel<String> effectSelectModel = new SelectionModel.withList(selectedValues: [effects[0]]);

  String get singleSelectEffectLabel =>
      effectSelectModel.selectedValues.length > 0 ? effectSelectModel.selectedValues.first : 'Select Effect';
  String get singleSelectedEffect =>
      effectSelectModel.selectedValues.isNotEmpty ? effectSelectModel.selectedValues.first : null;

  static List<String> paths = Path.values.map((e) => e.name).toList();
  SelectionOptions<String> pathList = new SelectionOptions.fromList(paths);
  SelectionModel<String> pathSelectModel = new SelectionModel.withList(selectedValues: [paths[0]]);
  String get singleSelectPathLabel =>
      pathSelectModel.selectedValues.length > 0 ? pathSelectModel.selectedValues.first : 'Select Path';
  String get singleSelectedPath =>
      pathSelectModel.selectedValues.isNotEmpty ? pathSelectModel.selectedValues.first : null;
}
