import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

@Component(
  selector: 'mjw-traitmodifier-list-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[CORE_DIRECTIVES, materialDirectives],
  template: '''
    <div>
      <div class='left-component-wrap'>
        <material-button icon class='add-btn material-list-item-secondary' (trigger)='addTraitModifier()'>
          <glyph icon='add_circle'></glyph>
        </material-button>
        <div class='left-component subheading'>TRAIT MODIFIERS</div>
      </div>
      <material-list>
        <material-list-item *ngFor='let item of traitModifiers.traitModifiers; let i = index'>
          <material-input style="width: 100%;" label="ENHANCEMENT" floatingLabel [(ngModel)]="item.name">
          </material-input>
          <material-input type="number"
                          checkInteger
                          trailingText="%"
                          rightAlign="true"
                          [(ngModel)]="item.level">
          </material-input>
          <material-button icon class='material-list-item-secondary' (trigger)='removeTraitModifier(i)'>
            <glyph icon='remove_circle' class='remove-button'></glyph>
          </material-button>
        </material-list-item>
      </material-list>
    </div>
  ''',
  providers: const <dynamic>[materialProviders],
)
class TraitModifierListEditor {
  @Input()
  TraitModifiable traitModifiers;

  // == TraitModifier add/remove button support ==
  void addTraitModifier() {
    traitModifiers.addTraitModifier(null, null, 0);
  }

  void removeEffect(int index) {
    traitModifiers.removeAt(index);
  }
}