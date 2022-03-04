

extension DurationUtils on int {
  Duration seconds() {
    return Duration(seconds: this);
  }

}

extension StringUtils on String {
  String convertWithComma(){
    String value = this;
    var buffer = new StringBuffer();

    if(value.length == 4){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
    }else if(value.length == 5){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
    }else if(value.length == 6){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
    }else if(value.length == 7){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(',');
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(value[6]);
    }else if(value.length == 8){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(',');
      buffer.write(value[5]);
      buffer.write(value[6]);
      buffer.write(value[7]);
    }else if(value.length == 9){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(',');
      buffer.write(value[6]);
      buffer.write(value[7]);
      buffer.write(value[8]);
    }
    else{
      for (int i = 0; i < value.length; i++) {
        // print('lllllf $i');
        buffer.write(value[i]);
        var nonZeroIndex = i + 1;

        if (nonZeroIndex % 3 == 0 && nonZeroIndex != value.length) {
          buffer.write(',');
        }

      }
    }

    return buffer.toString();

  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}