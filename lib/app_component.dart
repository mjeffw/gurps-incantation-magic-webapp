// Copyright (c) 2017, jeff. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders],
)
class AppComponent {
  static List<String> effects = ['Sense', 'Strengthen', 'Restore', 'Control', 'Destroy', 'Create', 'Transform'];
  SelectionOptions<String> effectList = new SelectionOptions.fromList(effects);
  SelectionModel<String> effectSelectModel = new SelectionModel.withList(selectedValues: [effects[0]]);
  String get singleSelectEffectLabel =>
      effectSelectModel.selectedValues.length > 0 ? effectSelectModel.selectedValues.first : 'Select Language';
  String get singleSelectedEffect =>
      effectSelectModel.selectedValues.isNotEmpty ? effectSelectModel.selectedValues.first : null;

  static List<String> paths = [
    'Arcanum',
    'Augury',
    'Demonology',
    'Elementalism',
    'Mesmerism',
    'Necromancy',
    'Protection',
    'Transfiguration'
  ];
  SelectionOptions<String> pathList = new SelectionOptions.fromList(paths);
  SelectionModel<String> pathSelectModel = new SelectionModel.withList(selectedValues: [paths[0]]);
  String get singleSelectPathLabel =>
      pathSelectModel.selectedValues.length > 0 ? pathSelectModel.selectedValues.first : 'Select Language';
  String get singleSelectedPath =>
      pathSelectModel.selectedValues.isNotEmpty ? pathSelectModel.selectedValues.first : null;

  String name = 'Alarm';
  List<String> strings = ['foo', 'bar', 'baz'];

  List<Map<String, String>> modifiers = [
    {'name': 'Altered Traits', 'descr': 'Damage Resistance 6 (Hardened 2, +40%; Tough Skin, -40%) (30)'},
    {'name': 'Duration', 'descr': '12 minutes (6)'},
    {'name': 'Subject Weight', 'descr': '1000 lbs. (4)'}
  ];
}
