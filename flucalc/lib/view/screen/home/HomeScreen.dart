import 'package:auto_size_text/auto_size_text.dart';
import 'package:flucalc/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum MathOperation { ADDITION, SUBSTRACTION, MULTIPLICATION, DIVISION }

class _HomeScreenState extends State<HomeScreen> {
  String firstInput = Constant.EMPTY_STRING;
  String secondInput = Constant.EMPTY_STRING;
  MathOperation currentOperation;

  Widget output;

  @override
  void initState() {
    super.initState();
    firstInput = Constant.EMPTY_STRING;
    secondInput = Constant.EMPTY_STRING;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateOutput();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: getHomeAppBar(),
      body: getHomeBody(),
    );
  }

  Widget getHomeAppBar() {
    return AppBar(
      title: Text(
        Constant.APP_NAME,
        style: TextStyle(
          color: Constant.COLOR_TEXT_DARK,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Theme.of(context).accentColor,
      shadowColor: Theme.of(context).accentColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Constant.COLOR_TEXT_DARK,
          ),
          onPressed: () {
            onInputShare();
          },
        ),
      ],
    );
  }

  Widget getHomeBody() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(Constant.PADDING_CALC_BORDER),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCalcScreenTop(),
            getCalcScreenMid(Constant.COLOR_EXTRA_SELECTED),
            getCalcScreenBottom(),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(Constant.SYMBOL_BACK, 1, (symbol) {
                onInputBack();
              }, isBackEnabled(), Constant.COLOR_DISABLED, Constant.COLOR_EXTRA_2, Constant.COLOR_TEXT_LIGHT, Constant.COLOR_TEXT_DARK, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_CLEAR, 1, (symbol) {
                onInputClear();
              }, false, Constant.COLOR_EXTRA_2, Constant.COLOR_EXTRA_2_SELECTED, Constant.COLOR_TEXT_DARK),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_INVERT, 1, (symbol) {
                onInputInvert();
              }, isCurrentInputNegative(), Constant.COLOR_EXTRA, Constant.COLOR_EXTRA_SELECTED),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_DIVISION, 1, (symbol) {
                onInputDivide();
              }, currentOperation == MathOperation.DIVISION, Constant.COLOR_EXTRA, Constant.COLOR_EXTRA_SELECTED)
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(Constant.SYMBOL_NUMBER_7, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_8, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_9, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_ADDITION, 1, (symbol) {
                onInputPlus();
              }, currentOperation == MathOperation.ADDITION, Constant.COLOR_EXTRA, Constant.COLOR_EXTRA_SELECTED)
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(Constant.SYMBOL_NUMBER_4, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_5, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_6, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_SUBSTRACTION, 1, (symbol) {
                onInputMinus();
              }, currentOperation == MathOperation.SUBSTRACTION, Constant.COLOR_EXTRA, Constant.COLOR_EXTRA_SELECTED),
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(Constant.SYMBOL_NUMBER_1, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_2, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_NUMBER_3, 1, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_MULTIPLICATION, 1, (symbol) {
                onInputMultiply();
              }, currentOperation == MathOperation.MULTIPLICATION, Constant.COLOR_EXTRA, Constant.COLOR_EXTRA_SELECTED),
            ]),
            getCalcItemsPadding(),
            getCalcRow([
              getCalcButton(Constant.SYMBOL_NUMBER_0, 2, (symbol) {
                onInputNumber(symbol);
              }, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.DECIMAL_SEPARATOR, 1, (symbol) {
                onInputDecimalSymbol();
              }, getCurrentInput().contains(Constant.DECIMAL_SEPARATOR), null, Constant.COLOR_DISABLED, Constant.COLOR_TEXT_LIGHT,
                  Constant.COLOR_TEXT_LIGHT, false),
              getCalcItemsPadding(),
              getCalcButton(Constant.SYMBOL_RESULT, 1, (symbol) {
                onInputResult();
              }, false, Constant.COLOR_EXTRA_2, Constant.COLOR_EXTRA_2_SELECTED, Constant.COLOR_TEXT_DARK),
            ]),
            getCalcItemsPadding(),
          ],
        ),
      ),
    ));
  }

  Widget getCalcScreenTop([Color colorText = Constant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(Constant.PADDING_CALC_ITEMS),
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

  Widget getCalcScreenMid([Color colorText = Constant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(Constant.PADDING_CALC_ITEMS),
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

  Widget getCalcScreenBottom([Color colorText = Constant.COLOR_TEXT_DARK]) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(Constant.PADDING_CALC_ITEMS),
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

  Padding getCalcItemsPadding() => Padding(padding: EdgeInsets.all(Constant.PADDING_CALC_ITEMS));

  Widget getCalcRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getCalcButton(String text, int rowSpaces, Function(String) callback,
      [bool selected = false,
      Color colorBG,
      Color colorBGSelected,
      Color colorText = Constant.COLOR_TEXT_LIGHT,
      Color colorTextSelected = Constant.COLOR_TEXT_LIGHT,
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

  String getOutput() =>
      getOutputFirst() + (currentOperation != null ? " ${getSymbol(currentOperation)} " : Constant.EMPTY_STRING) + getOutputSecond();

  String getOutputFirst() {
    if (firstInput.isNotEmpty) {
      return firstInput;
    } else {
      return "${Constant.DEFAULT_EMPTY_VALUE}";
    }
  }

  String getOutputSecond() {
    if (secondInput.isNotEmpty) {
      return secondInput;
    }
    return Constant.EMPTY_STRING;
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
      input = Constant.EMPTY_STRING;
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
    if (!input.contains(Constant.DECIMAL_SEPARATOR)) {
      if (input.isEmpty) {
        input = "${Constant.INTEGER_STARTING_OPTIONAL}${Constant.DECIMAL_SEPARATOR}";
      } else {
        input += Constant.DECIMAL_SEPARATOR;
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
    firstInput = Constant.EMPTY_STRING;
    secondInput = Constant.EMPTY_STRING;
    updateOutput();
  }

  void onInputNumber(String number) => setCurrentInput("${getCurrentInput()}${int.parse(number)}");

  void onInputInvert() {
    var input = getCurrentInput();
    if (input.isNotEmpty) {
      if (input.startsWith(Constant.SYMBOL_SUBSTRACTION)) {
        setCurrentInput(input.substring(1));
      } else {
        setCurrentInput(Constant.SYMBOL_SUBSTRACTION + input);
      }
    } else {
      setCurrentInput(Constant.SYMBOL_SUBSTRACTION + "${Constant.INTEGER_STARTING_OPTIONAL}");
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
    var firstValue = Constant.INTEGER_STARTING_OPTIONAL;
    var secondValue;
    try {
      firstValue = num.parse(firstInput);
    } catch (e) {
      firstValue = Constant.INTEGER_STARTING_OPTIONAL;
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
    secondInput = Constant.EMPTY_STRING;
    updateOutput();
  }

  void onInputShare() => Share.share(getOutput());

  void updateOutput() {
    setState(() {});
  }

  String removeStartZeroesIfOptional(String number) {
    var startNegative = number.startsWith(Constant.SYMBOL_SUBSTRACTION);
    var startIndex = (startNegative ? 2 : 1);
    var startingPattern =
        startNegative ? Constant.SYMBOL_SUBSTRACTION + "${Constant.INTEGER_STARTING_OPTIONAL}" : "${Constant.INTEGER_STARTING_OPTIONAL}";
    while (number.startsWith(startingPattern) && number.length > startIndex && number[startIndex] != Constant.DECIMAL_SEPARATOR) {
      if (startNegative) {
        number = number.substring(0, 1) + number.substring(2);
      } else {
        number = number.substring(startIndex);
      }
    }
    return number;
  }

  String removeDecimalIfOptional(String number) {
    while ((number.indexOf(Constant.DECIMAL_SEPARATOR) < number.length - 1 &&
            number.indexOf(Constant.DECIMAL_SEPARATOR) >= 0 &&
            number.endsWith("${Constant.DECIMAL_ENDING_OPTIONAL}")) ||
        number.endsWith(Constant.DECIMAL_SEPARATOR)) {
      number = number.substring(0, number.length - 1);
    }
    return number;
  }

  void setFirstValueIfEmpty() {
    if (firstInput.isEmpty) firstInput = "${Constant.DEFAULT_EMPTY_VALUE}";
  }

  bool isBackEnabled() {
    return (firstInput.isNotEmpty && firstInput != "${Constant.INTEGER_STARTING_OPTIONAL}") || currentOperation != null || secondInput.isNotEmpty;
  }

  bool isCurrentInputNegative() {
    try {
      return num.parse(getCurrentInput()) < 0;
    } catch (e) {}
    return false;
  }

  String getSymbol(MathOperation operation) {
    if (currentOperation == MathOperation.ADDITION) {
      return Constant.SYMBOL_ADDITION;
    } else if (currentOperation == MathOperation.SUBSTRACTION) {
      return Constant.SYMBOL_SUBSTRACTION;
    } else if (currentOperation == MathOperation.MULTIPLICATION) {
      return Constant.SYMBOL_MULTIPLICATION;
    } else if (currentOperation == MathOperation.DIVISION) {
      return Constant.SYMBOL_DIVISION;
    }
    return Constant.EMPTY_STRING;
  }
}
