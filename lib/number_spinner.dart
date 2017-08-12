import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';

@Component(
  selector: 'mjw-number-spinner',
  styleUrls: const ['app_component.css'],
  directives: const <dynamic>[CORE_DIRECTIVES, materialDirectives],
  template: '''
     <div class="mjw-number-spinner">
      <material-button icon (trigger)='increment()'><glyph icon='add_circle'></glyph></material-button>
      <material-button icon (trigger)='decrement()'><glyph icon='remove_circle'></glyph></material-button>
      <span class="mjw-label">{{value}} {{label}}</span>
    </div>
  ''',
  providers: const <dynamic>[materialProviders],
)
class NumberSpinner {
  @Input()
  int value;

  @Input()
  String label;

  void increment() { value++; }
  void decrement() { value--; }
}