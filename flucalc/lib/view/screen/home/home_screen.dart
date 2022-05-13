import 'package:auto_size_text/auto_size_text.dart';
import 'package:flucalc/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstInput = FlucalcConstant.EMPTY_STRING;
  String secondInput = FlucalcConstant.EMPTY_STRING;
  MathOperation? currentOperation;

  @override
  void initState() {
    super.initState();
    firstInput = FlucalcConstant.EMPTY_STRING;
    secondInput = FlucalcConstant.EMPTY_STRING;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateOutput();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: getHomeBody(),
    );
  }

  Widget getHomeBody() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(FlucalcConstant.PADDING_CALC_BORDER),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCalcScreenTop(),
            getCalcScreenMid(FlucalcConstant.COLOR_EXTRA_SELECTED),
            getCalcScreenBottom(),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(FlucalcConstant.SYMBOL_BACK, 1, (symbol) {
                onInputBack();
              }, isBackEnabled(), FlucalcConstant.COLOR_DISABLED, FlucalcConstant.COLOR_EXTRA_2, FlucalcConstant.COLOR_TEXT_LIGHT, FlucalcConstant.COLOR_TEXT_DARK, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_CLEAR, 1, (symbol) {
                onInputClear();
              }, false, FlucalcConstant.COLOR_EXTRA_2, FlucalcConstant.COLOR_EXTRA_2_SELECTED, FlucalcConstant.COLOR_TEXT_DARK),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_INVERT, 1, (symbol) {
                onInputInvert();
              }, isCurrentInputNegative(), FlucalcConstant.COLOR_EXTRA, FlucalcConstant.COLOR_EXTRA_SELECTED),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_DIVISION, 1, (symbol) {
                onInputDivide();
              }, currentOperation == MathOperation.DIVISION, FlucalcConstant.COLOR_EXTRA, FlucalcConstant.COLOR_EXTRA_SELECTED)
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_7, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_8, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_9, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_ADDITION, 1, (symbol) {
                onInputPlus();
              }, currentOperation == MathOperation.ADDITION, FlucalcConstant.COLOR_EXTRA, FlucalcConstant.COLOR_EXTRA_SELECTED)
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_4, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_5, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_6, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_SUBSTRACTION, 1, (symbol) {
                onInputMinus();
              }, currentOperation == MathOperation.SUBSTRACTION, FlucalcConstant.COLOR_EXTRA, FlucalcConstant.COLOR_EXTRA_SELECTED),
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_1, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_2, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_3, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_MULTIPLICATION, 1, (symbol) {
                onInputMultiply();
              }, currentOperation == MathOperation.MULTIPLICATION, FlucalcConstant.COLOR_EXTRA, FlucalcConstant.COLOR_EXTRA_SELECTED),
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(FlucalcConstant.SYMBOL_NUMBER_0, 2, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.DECIMAL_SEPARATOR, 1, (symbol) {
                onInputDecimalSymbol();
              }, getCurrentInput().contains(FlucalcConstant.DECIMAL_SEPARATOR), null, FlucalcConstant.COLOR_DISABLED, FlucalcConstant.COLOR_TEXT_LIGHT,
                  FlucalcConstant.COLOR_TEXT_LIGHT, false),
              getCalcItemsPadding(),
              getCalcButton(FlucalcConstant.SYMBOL_RESULT, 1, (symbol) {
                onInputResult();
              }, false, FlucalcConstant.COLOR_EXTRA_2, FlucalcConstant.COLOR_EXTRA_2_SELECTED, FlucalcConstant.COLOR_TEXT_DARK),
            ]),
            getCalcItemsPadding(),
          ],
        ),
      ),
    ));
  }

  Widget getCalcScreenTop([Color colorText = FlucalcConstant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(FlucalcConstant.PADDING_CALC_ITEMS),
        child: AutoSizeText(
          "${getOutputFirst()}",
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 72,
            color: colorText,
          ),
        ),
      ),
      flex: 1,
    );
  }

  Widget getCalcScreenMid([Color colorText = FlucalcConstant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(FlucalcConstant.PADDING_CALC_ITEMS),
        child: AutoSizeText(
          "  ${getSymbol(currentOperation)}  ",
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 72,
            color: colorText,
          ),
        ),
      ),
      flex: 1,
    );
  }

  Widget getCalcScreenBottom([Color colorText = FlucalcConstant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(FlucalcConstant.PADDING_CALC_ITEMS),
        child: AutoSizeText(
          "${getOutputSecond()}",
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 72,
            color: colorText,
          ),
        ),
      ),
      flex: 1,
    );
  }

  Padding getCalcItemsPadding() => Padding(padding: EdgeInsets.all(FlucalcConstant.PADDING_CALC_ITEMS));

  Widget getCalcRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getCalcButton(String text, int rowSpaces, Function(String) callback,
      [bool selected = false,
      Color? colorBG,
      Color? colorBGSelected,
      Color colorText = FlucalcConstant.COLOR_TEXT_LIGHT,
      Color colorTextSelected = FlucalcConstant.COLOR_TEXT_LIGHT,
      bool bold = true]) {
    var fontWeight;
    var bg;
    var textColor;
    if (selected) {
      if (bold) {
        fontWeight = FontWeight.bold;
      } else {
        fontWeight = FontWeight.normal;
      }
      bg = colorBGSelected;
      textColor = colorTextSelected;
    } else {
      fontWeight = FontWeight.normal;
      bg = colorBG;
      textColor = colorText;
    }
    return Expanded(
      child: Container(
        height: 80,
        child: RawMaterialButton(
          onPressed: () {
            callback(text);
          },
          fillColor: bg ??= Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99999)),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 33, color: textColor, fontWeight: fontWeight),
          ),
        ),
      ),
      flex: rowSpaces,
    );
  }

  String getOutputFirst() {
    if (firstInput.isNotEmpty) {
      return firstInput;
    } else {
      return "${FlucalcConstant.DEFAULT_EMPTY_VALUE}";
    }
  }

  String getOutputSecond() {
    if (secondInput.isNotEmpty) {
      return secondInput;
    }
    return FlucalcConstant.EMPTY_STRING;
  }

  String getCurrentInput() {
    if (currentOperation == null) {
      return firstInput;
    } else {
      return secondInput;
    }
  }

  void setCurrentInput(String input) {
    try {
      num.parse(input);
    } catch (e) {
      input = FlucalcConstant.EMPTY_STRING;
    }
    input = removeStartZeroesIfOptional(input);
    if (currentOperation == null) {
      firstInput = input;
    } else {
      secondInput = input;
    }
    updateOutput();
  }

  void onInputDecimalSymbol() {
    var input = getCurrentInput();
    if (!input.contains(FlucalcConstant.DECIMAL_SEPARATOR)) {
      if (input.isEmpty) {
        input = "${FlucalcConstant.INTEGER_STARTING_OPTIONAL}${FlucalcConstant.DECIMAL_SEPARATOR}";
      } else {
        input += FlucalcConstant.DECIMAL_SEPARATOR;
      }
      setCurrentInput(input);
    }
  }

  void onInputBack() {
    if (secondInput.isNotEmpty) {
      setCurrentInput(secondInput.substring(0, secondInput.length - 1));
    } else if (currentOperation != null) {
      currentOperation = null;
    } else if (firstInput.isNotEmpty) {
      setCurrentInput(firstInput.substring(0, firstInput.length - 1));
    }
    updateOutput();
  }

  void onInputClear() {
    currentOperation = null;
    firstInput = FlucalcConstant.EMPTY_STRING;
    secondInput = FlucalcConstant.EMPTY_STRING;
    updateOutput();
  }

  void onInputNumber(String number) => setCurrentInput("${getCurrentInput()}${int.parse(number)}");

  void onInputInvert() {
    var input = getCurrentInput();
    if (input.isNotEmpty) {
      if (input.startsWith(FlucalcConstant.SYMBOL_SUBSTRACTION)) {
        setCurrentInput(input.substring(1));
      } else {
        setCurrentInput(FlucalcConstant.SYMBOL_SUBSTRACTION + input);
      }
    } else {
      setCurrentInput(FlucalcConstant.SYMBOL_SUBSTRACTION + "${FlucalcConstant.INTEGER_STARTING_OPTIONAL}");
    }
  }

  void onInputDivide() => onInputMathOperation(MathOperation.DIVISION);

  void onInputMultiply() => onInputMathOperation(MathOperation.MULTIPLICATION);

  void onInputMinus() => onInputMathOperation(MathOperation.SUBSTRACTION);

  void onInputPlus() => onInputMathOperation(MathOperation.ADDITION);

  void onInputMathOperation(MathOperation operation) {
    if (firstInput.isNotEmpty) {
      firstInput = removeDecimalIfOptional(firstInput);
    }
    if (secondInput.isNotEmpty) {
      secondInput = removeDecimalIfOptional(secondInput);
      onInputResult();
    }
    currentOperation = operation;
    updateOutput();
  }

  void onInputResult() {
    setFirstValueIfEmpty();
    num firstValue = FlucalcConstant.INTEGER_STARTING_OPTIONAL;
    var secondValue;
    try {
      firstValue = num.parse(firstInput);
    } catch (e) {
      firstValue = FlucalcConstant.INTEGER_STARTING_OPTIONAL;
    }
    try {
      secondValue = num.parse(secondInput);
    } catch (e) {}
    if (secondValue != null) {
      if (currentOperation == MathOperation.ADDITION) {
        firstInput = "${firstValue + secondValue}";
      } else if (currentOperation == MathOperation.SUBSTRACTION) {
        firstInput = "${firstValue - secondValue}";
      } else if (currentOperation == MathOperation.MULTIPLICATION) {
        firstInput = "${firstValue * secondValue}";
      } else if (currentOperation == MathOperation.DIVISION) {
        firstInput = "${firstValue / secondValue}";
      }
    }
    firstInput = removeDecimalIfOptional(firstInput);
    currentOperation = null;
    secondInput = FlucalcConstant.EMPTY_STRING;
    updateOutput();
  }

  void updateOutput() {
    setState(() {});
  }

  String removeStartZeroesIfOptional(String number) {
    var startNegative = number.startsWith(FlucalcConstant.SYMBOL_SUBSTRACTION);
    var startIndex = (startNegative ? 2 : 1);
    var startingPattern =
        startNegative ? FlucalcConstant.SYMBOL_SUBSTRACTION + "${FlucalcConstant.INTEGER_STARTING_OPTIONAL}" : "${FlucalcConstant.INTEGER_STARTING_OPTIONAL}";
    while (number.startsWith(startingPattern) && number.length > startIndex && number[startIndex] != FlucalcConstant.DECIMAL_SEPARATOR) {
      if (startNegative) {
        number = number.substring(0, 1) + number.substring(2);
      } else {
        number = number.substring(startIndex);
      }
    }
    return number;
  }

  String removeDecimalIfOptional(String number) {
    while ((number.indexOf(FlucalcConstant.DECIMAL_SEPARATOR) < number.length - 1 &&
            number.indexOf(FlucalcConstant.DECIMAL_SEPARATOR) >= 0 &&
            number.endsWith("${FlucalcConstant.DECIMAL_ENDING_OPTIONAL}")) ||
        number.endsWith(FlucalcConstant.DECIMAL_SEPARATOR)) {
      number = number.substring(0, number.length - 1);
    }
    return number;
  }

  void setFirstValueIfEmpty() {
    if (firstInput.isEmpty) firstInput = "${FlucalcConstant.DEFAULT_EMPTY_VALUE}";
  }

  bool isBackEnabled() {
    return (firstInput.isNotEmpty && firstInput != "${FlucalcConstant.INTEGER_STARTING_OPTIONAL}") || currentOperation != null || secondInput.isNotEmpty;
  }

  bool isCurrentInputNegative() {
    try {
      return num.parse(getCurrentInput()) < 0;
    } catch (e) {}
    return false;
  }

  String getSymbol(MathOperation? operation) {
    if (currentOperation == MathOperation.ADDITION) {
      return FlucalcConstant.SYMBOL_ADDITION;
    } else if (currentOperation == MathOperation.SUBSTRACTION) {
      return FlucalcConstant.SYMBOL_SUBSTRACTION;
    } else if (currentOperation == MathOperation.MULTIPLICATION) {
      return FlucalcConstant.SYMBOL_MULTIPLICATION;
    } else if (currentOperation == MathOperation.DIVISION) {
      return FlucalcConstant.SYMBOL_DIVISION;
    }
    return FlucalcConstant.EMPTY_STRING;
  }
}
