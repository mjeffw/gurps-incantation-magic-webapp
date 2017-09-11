// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'effectlist_editor.dart';
import 'modifierlist_editor.dart';
import 'modifier_editor.dart';
import 'spell_text.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components
typedef RitualModifier Creator();

@Component(
  selector: 'mjw-spell-editor',
  styleUrls: const ['spell_editor.css'],
  template: '''
    <div>
      <material-input label='SPELL NAME' floatingLabel class='title' [(ngModel)]='spell.name'></material-input>
    </div>
    
    <div>
      <mjw-effectlist-editor [effects]='spell.effects'></mjw-effectlist-editor>
    </div>
    
    <div>
      <mjw-modifierlist-editor [ritualModifiers]='spell.ritualModifiers'></mjw-modifierlist-editor>
    </div>
    
    <!-- TODO Add a list for Drawbacks? -->
    <div>
      <material-checkbox label='Conditional' [(checked)]='spell.conditional'></material-checkbox>
    </div>
    
    <div>
      <material-input multiline rows='4' floatingLabel label='DESCRIPTION' class='description' 
        [(ngModel)]='spell.description'></material-input>
    </div>
    
    <div>
      <material-button class='red' raised (trigger)='createSpell()'>Clear</material-button>
    </div>
    
    <div>
      <mjw-spell-text [spell]='spell'></mjw-spell-text>
    </div>  
    ''',
  directives: const <dynamic>[
    CORE_DIRECTIVES,
    materialDirectives,
    EffectListEditor,
    ModifierListEditor,
    ModifierEditor,
    SpellText
  ],
  providers: const <dynamic>[materialProviders],
)
class SpellEditor {
  Spell _spell;

  void createSpell() {
    _spell = new Spell();
  }

  Spell get spell {
    if (_spell == null) {
      createSpell();
    }
    return _spell;
  }
}
