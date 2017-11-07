import 'package:angular_components/angular_components.dart';
import 'package:angular/angular.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';
import 'modifier_editor.dart';
import 'package:observable/observable.dart';

typedef RitualModifier Creator();

@Component(
  selector: 'mjw-modifierlist-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    ModifierEditor,
    AutoDismissDirective,
    AutoFocusDirective,
    MaterialButtonComponent,
    MaterialDialogComponent,
    MaterialIconComponent,
    ModalComponent,
  ],
  template: '''
  <div class='left-component-wrap'>
    <material-button icon class='add-btn material-list-item-secondary'
                     (trigger)='showModifierDialog = true'
                     [disabled]='showModifierDialog'>
      <glyph icon='add_circle'></glyph>
    </material-button>
    <div class='left-component subheading'>RITUAL MODIFIERS</div>
  </div>

  <!-- add Modifier dialog -->
  <modal [visible]='showModifierDialog'>
    <material-dialog class='basic-dialog'>
      <h3 header>Select Ritual Modifier</h3>
      <material-dropdown-select
          autofocus
          [buttonText]='modifierSelectModel.selectedValues.first'
          [selection]='modifierSelectModel'
          [options]='modifierOptions'>
      </material-dropdown-select>
      <div footer>
        <material-button (trigger)='showModifierDialog = false' class='white'>
           CANCEL
        </material-button>
        <material-button (trigger)='addModifier()' class='blue'>
          ADD MODIFIER
        </material-button>
      </div>
    </material-dialog>
  </modal>

  <div *ngFor='let item of ritualModifiers; let i = index'>
    <mjw-modifier-editor [ritualModifiers]='ritualModifiers' [modifier]='item' [index]='i'></mjw-modifier-editor>
  </div>
  <material-list></material-list>
  ''',
  providers: const <dynamic>[materialProviders],
)
class ModifierListEditor {
  static Map<String, Creator> map = {
    "Afflictions": () => new Affliction(null),
    "Afflictions (Stun)": () => new AfflictionStun(),
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

  @Input()
  List<RitualModifier> ritualModifiers;

  bool showModifierDialog = false;

  final SelectionOptions<String> modifierOptions = new SelectionOptions.fromList(map.keys.toList(growable: false));

  final SelectionModel<String> modifierSelectModel =
      new SelectionModel.withList(selectedValues: [map.keys.toList(growable: false)[0]]);

  void addModifier() {
    ritualModifiers.add(map[modifierSelectModel.selectedValues.first]());
    showModifierDialog = false;
  }
}
