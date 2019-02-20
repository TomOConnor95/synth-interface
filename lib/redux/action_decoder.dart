import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import './actions.dart';

class MyDecoder extends ActionDecoder {
  dynamic decode(dynamic payload) {
    final map = payload as Map<String, dynamic>;
    if (map['type'] == 'SavePreset') {
      return SavePreset();
    }
    if (map['type'] == 'DeletePreset') {
      return DeletePreset(map['presetNumber']);
    }
    if (map['type'] == 'DeletePreset') {
      return DeletePreset(map['payload'].blendValue);
    }
    if (map['type'] == 'RecallPreset') {
      return RecallPreset(map['payload'].presetNumber);
    }
    if (map['type'] == 'RandomiseParameters') {
      return RandomiseParameters(
        oscillatorToRandomise: map['payload'].oscillatorToRandomise,
      );
    }
    if (map['type'] == 'LengthCallback') {
      return LengthCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'FreqCallback') {
      return FreqCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'WidthAmpCallback') {
      return WidthAmpCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'WidthFreqCallback') {
      return WidthFreqCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'OpacityAmpCallback') {
      return OpacityAmpCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'OpacityFreqCallback') {
      return OpacityFreqCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'ColorCallback') {
      return ColorCallback(map['payload'].oscillatorNumber, map['payload'].value);
    }
    if (map['type'] == 'BlendPresets') {
      return BlendPresets();
    }
    if (map['type'] == 'LeftPresetSelectorCallback') {
      return LeftPresetSelectorCallback(map['payload'].presetNumber);
    }
    if (map['type'] == 'RightPresetSelectorCallback') {
      return LeftPresetSelectorCallback(map['payload'].presetNumber);
    }
    if (map['type'] == 'BlendSliderCallback') {
      return BlendSliderCallback(map['payload'].blendValue);
    }
  }
}
