import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:gurps_dart/gurps_dart.dart';

import 'trait_modifier_list_proxy.dart';

@Component(
  selector: 'mjw-drawback-list-editor',
  styleUrls: const ['spell_editor.css'],
  directives: const <dynamic>[
    coreDirectives,
    materialInputDirectives,
    MaterialNumberValueAccessor,
  ],
  template: '''
    <div class='left-component-wrap'>
      <material-button icon class='add-btn material-list-item-secondary' (trigger)='drawbacks.addProxy()'>
        <glyph icon='add_circle'></glyph>
      </material-button>
      <div class='left-component subheading'>DRAWBACKS</div>
    </div>
    
    <div *ngFor='let item of drawbacks; let i = index' class='left-component-wrap'>
      <span class="left-component">
        <material-input style='width: 70%;' type='text' label="LIMITATION" floatingLabel [(ngModel)]="item.name">
        </material-input>
        <material-input style='width: 12%;' type="number" checkInteger trailingText="%" rightAlign
          [(ngModel)]="item.percent"></material-input>
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
  TraitModifierListProxy drawbacks = TraitModifierListProxy();
}
