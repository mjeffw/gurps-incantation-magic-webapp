import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
@Component(
  selector: 'mjw-traitmodifier-list-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[
    coreDirectives,
    materialDirectives,
    materialInputDirectives,
    MaterialNumberValueAccessor,
  ],
  template: '''
    <div>
      <div class='left-component-wrap'>
        <material-button icon class='add-btn material-list-item-secondary' (trigger)='addTraitModifier()'>
          <glyph icon='add_circle'></glyph>
        </material-button>
        <div class='left-component subheading'>TRAIT MODIFIERS</div>
      </div>
      
      <div *ngFor='let item of traitModifiable.traitModifiers; let i = index' class='left-component-wrap'>
        <span class="left-component">
          <material-input style='width: 70%;' 
                          type='text' 
                          label="ENHANCEMENT" 
                          floatingLabel
                          [(ngModel)]="item.name">
          </material-input>
          <material-input style='width: 12%;' 
                          type="number"
                          checkInteger
                          trailingText="%"
                          rightAlign
                          [(ngModel)]="item.level">
          </material-input>
        </span>
       
          <material-button icon class='remove-btn' (trigger)='removeModifier(i)' style="margin-right: 24px;">
            <glyph icon='remove_circle'></glyph>
          </material-button>              
      </div> 
    </div>
  ''',
  providers: const <dynamic>[materialProviders],
)
class TraitModifierListEditor {
  TraitModifiable _traitModifiable;

  TraitModifiable get traitModifiable => _traitModifiable;

  @Input()
  set traitModifiable(TraitModifiable t) => _traitModifiable = t;

  // == TraitModifier add/remove button support ==
  void addTraitModifier() {
    _traitModifiable.addTraitModifier(new TraitModifier(null, null, 0));
  }

  void removeModifier(int index) {
    _traitModifiable.removeAt(index);
  }
}
