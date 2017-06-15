// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import "package:gurps_incantation_magic_model/incantation_magic.dart";
import 'package:observable/src/records.dart';

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
    _fillOutSpellEffectModelLists();
    return spell;
  }

  Spell get spell {
    if (_spell == null) {
      print('createSpell');
      _spell = createSpell();
    }
    return _spell;
  }

  // == Effect add/remove button support ==
  void addEffect() {
    SpellEffect e = new SpellEffect(Effect.Sense, Path.Arcanum);
    _createSelectionModels(e);
    _spell.addEffect(e);
  }

  void removeEffect(int index) {
    effectSelectModels.removeAt(index);
    _spell.removeEffect(index);
  }

  // == Effect dropdown select support ==
  SelectionOptions<Effect> effectList = new SelectionOptions.fromList(Effect.values);

  final List<SelectionModel<Effect>> effectSelectModels = [];

  void _changeEffectSelection(SelectionChangeRecord<Effect> item, SpellEffect effect, int index) {
    _spell.effects[index].effect = item.added.first;
  }

  // == Path dropdown select support ==
  SelectionOptions<Path> pathList = new SelectionOptions.fromList(Path.values);

  final List<SelectionModel<Path>> pathSelectModels = [];

  void _changePathSelection(SelectionChangeRecord<Path> item, SpellEffect e, int index) {
    _spell.effects[index].path = item.added.first;
  }

  // build the path and effect selection models
  void _fillOutSpellEffectModelLists() {
    pathSelectModels.clear();
    effectSelectModels.clear();
    _spell.effects.forEach((e) => _createSelectionModels(e));
  }

  void _createSelectionModels(SpellEffect e) {
    SelectionModel<Effect> effectSelectionModel = new SelectionModel.withList(selectedValues: [e.effect]);
    effectSelectionModel.selectionChanges.listen((list) {
      list.forEach((r) => _changeEffectSelection(r, e, effectSelectModels.indexOf(effectSelectionModel)));
    });
    effectSelectModels.add(effectSelectionModel);

    SelectionModel<Path> pathSelectionModel = new SelectionModel.withList(selectedValues: [e.path]);
    pathSelectionModel.selectionChanges.listen((list){
      list.forEach((r) => _changePathSelection(r, e, _spell.effects.indexOf(e)));
    });
    pathSelectModels.add(pathSelectionModel);
  }



  List<ModifierDetail> get modifierDetails => _spell.export(new TextSpellExporter()).modifierExporter.details;
}
