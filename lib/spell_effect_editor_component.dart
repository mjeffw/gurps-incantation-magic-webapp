import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

@Component(
  selector: 'spell-effect-editor',
  styleUrls: const ['app_component.css'],
  directives: const [CORE_DIRECTIVES, materialDirectives], // ignore: strong_mode_implicit_dynamic_list_literal
  template: '''
      <!-- Spell Effects table -->
      <div class='my-field-wrap'>
        <material-button icon class='add-btn material-list-item-secondary' (trigger)='addEffect()'>
          <glyph icon='add_circle'></glyph>
        </material-button>
        <div class='my-field subheading'>EFFECTS</div>
      </div>
      <material-list>
        <material-list-item *ngFor='let item of effects; let i = index'>
          <material-dropdown-select
                  [options]='effectList'
                  [buttonText]='item.effect.name'
                  [selection]='effectSelectModels[i]'>
          </material-dropdown-select>
          <material-dropdown-select
                [options]='pathList'
                [buttonText]='item.path.name'
                [selection]='pathSelectModels[i]'>
          </material-dropdown-select>
          <material-button icon class='material-list-item-secondary' (trigger)='removeEffect(i)'>
            <glyph icon='remove_circle' class='remove-button'></glyph>
          </material-button>
        </material-list-item>
      </material-list>
  ''',
  providers: const [materialProviders], // ignore: strong_mode_implicit_dynamic_list_literal
)
class SpellEffectEditorComponent {
  List<SpellEffect> _effects;

  SpellEffectEditorComponent() {
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
    effects.forEach((e) => _createSelectionModels(e));
  }

  void _createSelectionModels(SpellEffect e) {
    SelectionModel<Effect> effectSelectionModel = new SelectionModel.withList(selectedValues: [e.effect]);
    effectSelectionModel.selectionChanges.listen((list) {
      list.forEach((r) => _changeEffectSelection(r, e, effectSelectModels.indexOf(effectSelectionModel)));
    });
    effectSelectModels.add(effectSelectionModel);

    SelectionModel<Path> pathSelectionModel = new SelectionModel.withList(selectedValues: [e.path]);
    pathSelectionModel.selectionChanges.listen((list){
      list.forEach((r) => _changePathSelection(r, e, effects.indexOf(e)));
    });
    pathSelectModels.add(pathSelectionModel);
  }

  // == Effect add/remove button support ==
  void addEffect() {
    SpellEffect e = new SpellEffect(Effect.Sense, Path.Arcanum);
    _createSelectionModels(e);
    effects.add(e);
  }

  void removeEffect(int index) {
    effectSelectModels.removeAt(index);
    effects.removeAt(index);
  }

  // == Effect dropdown select support ==
  SelectionOptions<Effect> effectList = new SelectionOptions.fromList(Effect.values);
  final List<SelectionModel<Effect>> effectSelectModels = [];

  void _changeEffectSelection(SelectionChangeRecord<Effect> item, SpellEffect effect, int index) {
    effects[index].effect = item.added.first;
  }

  // == Path dropdown select support ==
  SelectionOptions<Path> pathList = new SelectionOptions.fromList(Path.values);
  final List<SelectionModel<Path>> pathSelectModels = [];

  void _changePathSelection(SelectionChangeRecord<Path> item, SpellEffect e, int index) {
    effects[index].path = item.added.first;
  }
}