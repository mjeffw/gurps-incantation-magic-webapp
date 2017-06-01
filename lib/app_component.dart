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

  String name = 'Alarm';
  List<String> strings = ['foo', 'bar', 'baz'];
  SelectionOptions<String> effectList = new SelectionOptions.fromList(effects);
  SelectionModel<String> effectSelectModel = new SelectionModel.withList(selectedValues: [effects[0]]);

  String get singleSelectEffectLabel =>
      effectSelectModel.selectedValues.length > 0 ? effectSelectModel.selectedValues.first : 'Select Language';

  String get singleSelectedEffect =>
      effectSelectModel.selectedValues.isNotEmpty ? effectSelectModel.selectedValues.first : null;
}
