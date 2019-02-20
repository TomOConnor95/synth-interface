import 'package:flutter/material.dart';


class SavePreset {
}

class DeletePreset {
  final int presetNumber;
  DeletePreset(this.presetNumber);

  toJson() {
    return {'presetNumber': this.presetNumber};
  }
}

class RecallPreset {
  final int presetNumber;
  RecallPreset(this.presetNumber);

  toJson() {
    return {'presetNumber': this.presetNumber};
  }
}

class RandomiseParameters {
  final int oscillatorToRandomise;
  RandomiseParameters({this.oscillatorToRandomise});

  toJson() {
    return {'oscillatorToRandomise': this.oscillatorToRandomise};
  }
}

class LengthCallback {
  final int oscillatorNumber;
  final double value;

  LengthCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class FreqCallback {
  final int oscillatorNumber;
  final int value;

  FreqCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class WidthAmpCallback {
  final int oscillatorNumber;
  final double value;

  WidthAmpCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class WidthFreqCallback {
  final int oscillatorNumber;
  final int value;

  WidthFreqCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class OpacityAmpCallback {
  final int oscillatorNumber;
  final double value;

  OpacityAmpCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class OpacityFreqCallback {
  final int oscillatorNumber;
  final int value;

  OpacityFreqCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class ColorCallback {
  final int oscillatorNumber;
  final Color value;

  ColorCallback(this.oscillatorNumber, this.value);

  toJson() {
    return {
      'oscillatorNumber': this.oscillatorNumber,
      'value': value,
    };
  }
}

class BlendPresets {}

class LeftPresetSelectorCallback {
  final int presetNumber;
  LeftPresetSelectorCallback(this.presetNumber);

  toJson() {
    return {'presetNumber': this.presetNumber};
  }
}

class RightPresetSelectorCallback {
  final int presetNumber;
  RightPresetSelectorCallback(this.presetNumber);

  toJson() {
    return {'presetNumber': this.presetNumber};
  }
}

class BlendSliderCallback {
  final double blendValue;
  BlendSliderCallback(this.blendValue);

  toJson() {
    return {'blendValue': this.blendValue};
  }
}
