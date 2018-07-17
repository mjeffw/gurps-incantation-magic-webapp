import 'package:angular_components/angular_components.dart';
import 'package:angular/angular.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

@Component(
  selector: 'mjw-effectlist-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[coreDirectives, materialDirectives],
  template: '''
      <!-- Spell Effects table -->
      <div class='left-component-wrap'>
        <material-button icon class='add-btn material-list-item-secondary' (trigger)='addEffect()'>
          <glyph icon='add_circle'></glyph>
        </material-button>
        <div class='left-component subheading'>SPELL EFFECTS</div>
      </div>
      <material-list>
        <material-list-item *ngFor='let item of effects; let i = index'>
          <material-dropdown-select 
            [options]='effectList' 
            [buttonText]='item.effect.name' 
            [selection]='effectSelectModels[i]'>
          </material-dropdown-select>
          <material-dropdown-select [options]='pathList' [buttonText]='item.path.name' [selection]='pathSelectModels[i]'>
          </material-dropdown-select>
          <material-button icon class='material-list-item-secondary' (trigger)='removeEffect(i)'>
            <glyph icon='remove_circle' class='remove-button'></glyph>
          </material-button>
        </material-list-item>
      </material-list>
  ''',
  providers: const <dynamic>[materialProviders],
)
class EffectListEditor {
  List<SpellEffect> _effects;

  EffectListEditor() {
    _effects = [];
    _fillOutModelLists();
  }

  List<SpellEffect> get effects => _effects;

  @Input()
  set effects(List<SpellEffect> list) {
    _effects = list;
    _fillOutModelLists();
  }

  // build the path and effect selection models
  void _fillOutModelLists() {
    pathSelectModels.clear();
    effectSelectModels.clear();
    effects.forEach((e) => _createSelectionModels(effects.indexOf(e)));
  }

  void _createSelectionModels(int index) {
    SpellEffect e = effects[index];

    {
      SelectionModel<Path> pathSelectionModel =
          new SelectionModel.single(selected: e.path);
      pathSelectionModel.selectionChanges.listen((aa) {
        aa.forEach((ar) => _changePathSelection(ar, index));
      });
      pathSelectModels.add(pathSelectionModel);
    }

    {
      SelectionModel<Effect> effectSelectionModel =
          new SelectionModel.single(selected: e.effect);
      effectSelectionModel.selectionChanges.listen((bb) {
        bb.forEach((br) => _changeEffectSelection(br, index));
      });
      effectSelectModels.add(effectSelectionModel);
    }
  }

  // == Effect add/remove button support ==
  void addEffect() {
    SpellEffect e = new SpellEffect(Effect.Sense, Path.arcanum);
    effects.add(e);
    _createSelectionModels(effects.indexOf(e));
  }

  void removeEffect(int index) {
    effectSelectModels.removeAt(index);
    effects.removeAt(index);
  }

  // == Effect dropdown select support ==
  SelectionOptions<Effect> effectList =
      new SelectionOptions.fromList(Effect.values);
  final List<SelectionModel<Effect>> effectSelectModels = [];

  void _changeEffectSelection(SelectionChangeRecord<Effect> item, int index) {
    effects[index].effect = item.added.first;
  }

  // == Path dropdown select support ==
  SelectionOptions<Path> pathList = new SelectionOptions.fromList(Path.values);
  final List<SelectionModel<Path>> pathSelectModels = [];

  void _changePathSelection(SelectionChangeRecord<Path> item, int index) {
    effects[index].path = item.added.first;
  }
}
