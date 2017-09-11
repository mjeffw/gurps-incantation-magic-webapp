import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_incantation_magic_model/incantation_magic.dart';

@Component(
  selector: 'mjw-drawback-list-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[
    CORE_DIRECTIVES,
    materialDirectives,
    materialInputDirectives,
    MaterialNumberValueAccessor,
  ],
  template: '''
    <div class='left-component-wrap'>
      <material-button icon class='add-btn material-list-item-secondary' (trigger)='addDrawback()'>
        <glyph icon='add_circle'></glyph>
      </material-button>
      <div class='left-component subheading'>DRAWBACKS</div>
    </div>
    
    <div *ngFor='let item of drawbacks; let i = index' class='left-component-wrap'>
      <span class="left-component">
        <material-input style='width: 70%;' type='text' label="LIMITATION" floatingLabel [(ngModel)]="item.name">
        </material-input>
        <material-input style='width: 12%;' type="number" checkInteger trailingText="%" rightAlign
          [(ngModel)]="item.level"></material-input>
      </span>
     
        <material-button icon class='remove-btn' (trigger)='drawbacks.removeAt(i)' style="margin-right: 24px;">
          <glyph icon='remove_circle'></glyph>
        </material-button>              
    </div> 
    <material-list></material-list>
  ''',
  providers: const <dynamic>[materialProviders],
)
class DrawbackListEditor {
  @Input()
  List<TraitModifier> drawbacks;

  void addDrawback() {
    drawbacks.add(new TraitModifier('', null, 0));
  }
}
