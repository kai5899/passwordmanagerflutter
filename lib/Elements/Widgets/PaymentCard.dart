import 'package:flutter/material.dart';

/// Types of Cards.
enum CardType {
  /// Credit Card
  credit,

  /// Debit Card
  debit,

  /// Prepaid Card
  prepaid,

  /// Gift Card
  giftCard,

  /// Others
  other,
}

/// Types of payment network.
enum CreditCardType {
  /// VISA
  visa,

  /// Mastercard
  mastercard,

  /// AMEX
  amex,

  /// Discover
  discover,

  /// None
  none,
}

/// Position of the Card Provider logo.
/// Left or Right in the top part of the card.
enum CardProviderLogoPosition {
  /// Set the logo to the left side.
  left,

  /// Set the logo to the left side.
  right;

  /// Find if the logo is set to left or not.
  bool get isLeft => this == CardProviderLogoPosition.left;
}

class UiConstants {
  /// Defines default animation duration (400ms)
  static const animationDuration = Duration(milliseconds: 400);

  /// Defines font family
  static const fontFamily = 'ocr-a';

  /// Defines package name
// static const packageName = 'u_credit_card';
}

class Assets {
  const Assets._();

  ///
  static const imagePath = 'assets/images';

  // Visa types logo
  /// Logo for Visa
  static const visaLogo = '$imagePath/visa_logo.png';

  /// Logo for Master card
  static const masterCardLogo = '$imagePath/master_card.png';

  /// Logo for American Express card
  static const amexLogo = '$imagePath/amex.png';

  /// Logo for Discover card
  static const discoverLogo = '$imagePath/discover.png';

  // Chips, NFC
  /// Chip image
  static const chip = '$imagePath/chip.png';

  /// NFC Icon
  static const nfc = '$imagePath/nfc.png';
}

class CreditCardAssetImage extends StatelessWidget {
  ///
  const CreditCardAssetImage({
    super.key,
    required this.assetPath,
  });

  ///
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.contain,
    );
  }
}

class CreditCardChipNfcView extends StatelessWidget {
  ///
  const CreditCardChipNfcView({
    super.key,
    required this.doesSupportNfc,
    required this.placeNfcIconAtTheEnd,
  });

  ///
  final bool doesSupportNfc;

  ///
  final bool placeNfcIconAtTheEnd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      child: Row(
        children: [
          ...[
            const SizedBox(width: 12),
            const SizedBox(
              height: 26,
              child: CreditCardAssetImage(
                assetPath: Assets.chip,
              ),
            ),
          ],
          if (placeNfcIconAtTheEnd) const Spacer(),
          if (!doesSupportNfc)
            const SizedBox.shrink()
          else ...[
            const SizedBox(width: 12),
            const SizedBox(
              height: 18,
              width: 25,
              child: CreditCardAssetImage(
                assetPath: Assets.nfc,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CreditCardText extends StatelessWidget {
  ///
  const CreditCardText(
    this.text, {
    super.key,
    this.letterSpacing = 3.2,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
  });

  ///
  final String text;

  ///
  final double letterSpacing;

  ///
  final double fontSize;

  ///
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: UiConstants.fontFamily,
      ),
      maxLines: 1,
      overflow: TextOverflow.clip,
    );
  }
}

class CreditCardHolderNameView extends StatelessWidget {
  ///
  const CreditCardHolderNameView({
    super.key,
    required this.cardHolderFullName,
  });

  ///
  final String cardHolderFullName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172,
      child: CreditCardText(
        cardHolderFullName.toUpperCase(),
        letterSpacing: 2,
        fontSize: 12,
      ),
    );
  }
}

class CreditCardTopLogo extends StatelessWidget {
  ///
  const CreditCardTopLogo({
    super.key,
    required this.cardType,
    this.cardProviderLogo,
    required this.cardProviderLogoPosition,
  });

  ///
  final CardType cardType;

  ///
  final Widget? cardProviderLogo;

  ///
  final CardProviderLogoPosition cardProviderLogoPosition;

  @override
  Widget build(BuildContext context) {
    String getCardTitle(CardType cardType) {
      switch (cardType) {
        case CardType.credit:
          return 'CREDIT';
        case CardType.debit:
          return 'DEBIT';
        case CardType.prepaid:
          return 'PREPAID';
        case CardType.giftCard:
          return 'GIFT CARD';
        case CardType.other:
          return '';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: cardProviderLogoPosition.isLeft
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: [
        Text(
          getCardTitle(cardType),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 8,
            letterSpacing: 1.5,
          ),
        ),
        cardProviderLogo ?? const SizedBox.shrink(),
      ],
    );
  }
}

class CreditCardValidityView extends StatelessWidget {
  ///
  const CreditCardValidityView({
    super.key,
    required this.validFromMasked,
    required this.validThruMasked,
    this.showValidFrom = true,
    this.showValidThru = true,
  });

  ///
  final String? validFromMasked;

  ///
  final String validThruMasked;

  /// Determines whether to show the "Valid From" segment on the card.
  ///
  /// If set to `true`, the "Valid From" segment will be displayed.
  /// If set to `false`, it will be hidden.
  /// The default value is `true`.
  final bool showValidFrom;

  /// Determines whether to show the "Valid Thru" segment on the card.
  ///
  /// If set to `true`, the "Valid Thru" segment will be displayed.
  /// If set to `false`, it will be hidden.
  /// The default value is `true`.
  final bool showValidThru;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility.maintain(
          visible: showValidFrom,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
                child: Text(
                  'VALID FROM',
                  style: TextStyle(
                    color: Color.fromARGB(255, 200, 200, 200),
                    fontSize: 5,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (validFromMasked == null)
                const SizedBox(width: 38)
              else
                CreditCardText(
                  validFromMasked!,
                  letterSpacing: 2,
                  fontSize: 9,
                ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Visibility.maintain(
          visible: showValidThru,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
                child: Text(
                  'VALID THRU',
                  style: TextStyle(
                    color: Color.fromARGB(255, 200, 200, 200),
                    fontSize: 5,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CreditCardText(
                validThruMasked,
                letterSpacing: 2,
                fontSize: 9,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreditCard {
  ///
  CreditCard(this.number);

  ///
  final String number;

  ///
  bool get isValid => _validate();

  ///
  CreditCardType get cardType => _detectCreditCardType();

  bool _validate() {
    final cardNumber = number.trim().replaceAll(RegExp('[^0-9]'), '');

    if (cardNumber.isEmpty) {
      return false;
    }

    var checksum = 0;
    var isOddDigit = true;

    for (var i = cardNumber.length - 1; i >= 0; i--) {
      var digit = int.parse(cardNumber[i]);

      if (isOddDigit) {
        checksum += digit;
      } else {
        digit *= 2;
        checksum += (digit > 9) ? digit - 9 : digit;
      }

      isOddDigit = !isOddDigit;
    }

    return checksum % 10 == 0;
  }

  CreditCardType _detectCreditCardType() {
    final cardNumber = number.trim().replaceAll(RegExp('[^0-9]'), '');

    if (cardNumber.isEmpty) {
      return CreditCardType.none;
    }

    if (cardNumber.startsWith('4')) {
      return CreditCardType.visa;
    }

    if (cardNumber.startsWith('5') && RegExp('^5[1-5]').hasMatch(cardNumber)) {
      return CreditCardType.mastercard;
    }

    if (cardNumber.startsWith('3') &&
        (cardNumber.startsWith('34') || cardNumber.startsWith('37'))) {
      return CreditCardType.amex;
    }

    if (cardNumber.startsWith('6') &&
        RegExp('^6(?:011|5[0-9]{2})').hasMatch(cardNumber)) {
      return CreditCardType.discover;
    }

    return CreditCardType.none;
  }
}

class CreditCardHelper {
  CreditCardHelper._();

  /// Masks Credit Card number with asterisks
  static String maskCreditCardNumber(String cardNumber) {
    final length = cardNumber.length;
    var maskedNumber = '';

    for (var i = 0; i < length; i++) {
      if (i < 4 || (i >= 12)) {
        // keep the first 4 digits and the last 4 digits visible
        maskedNumber += cardNumber[i];
      } else {
        // mask the digits between 4 and the length-4 with asterisks
        maskedNumber += '*';
      }
    }

    return groupDigits(maskedNumber);
  }

  /// Group the masked number in sets of 4 digits.
  static String groupDigits(String input) {
    if (input.isEmpty) {
      return input;
    }

    final groups = <String>[];
    final length = input.length;

    for (var i = 0; i < length; i += 4) {
      final groupLength = i + 4 <= length ? 4 : length - i;
      final group = input.substring(i, i + groupLength);
      groups.add(group);
    }

    return groups.join(' ');
  }

  /// Masks validity into `mm/yy`,
  /// and cut all the strings after the 5th character
  static String maskValidity(String validity) {
    if (validity.length < 5) {
      return validity;
    }

    return validity.substring(0, 5).replaceAll(' ', '').replaceAll('-', '/');
  }

  /// Returns a darker version of any color
  static Color getDarkerColor(Color color) {
    // Calculate the luminance of the input color
    final luminance = color.computeLuminance();

    // Set the amount by which you want to make the color darker
    const darkenAmount = 0.2;

    // Adjust the luminance to make the color darker
    final newLuminance = (luminance - darkenAmount).clamp(0.0, 1.0);

    // Return the new darker color
    return Color.fromRGBO(
      (color.red * newLuminance).toInt(),
      (color.green * newLuminance).toInt(),
      (color.blue * newLuminance).toInt(),
      color.opacity,
    );
  }

  /// Get Card Logo String based on `cardNumber`
  static String getCardLogoFromCardNumber({required String cardNumber}) {
    final creditCard = CreditCard(cardNumber);

    final cardType = creditCard.cardType;

    switch (cardType) {
      case CreditCardType.visa:
        return Assets.visaLogo;
      case CreditCardType.mastercard:
        return Assets.masterCardLogo;
      case CreditCardType.amex:
        return Assets.amexLogo;
      case CreditCardType.discover:
        return Assets.discoverLogo;
      case CreditCardType.none:
        return '';
    }
  }

  /// Get Card Logo String based on [CreditCardType]
  static String getCardLogoFromType({required CreditCardType creditCardType}) {
    final cardType = creditCardType;

    switch (cardType) {
      case CreditCardType.visa:
        return Assets.visaLogo;
      case CreditCardType.mastercard:
        return Assets.masterCardLogo;
      case CreditCardType.amex:
        return Assets.amexLogo;
      case CreditCardType.discover:
        return Assets.discoverLogo;
      case CreditCardType.none:
        return '';
    }
  }
}

class PaymentCardUi extends StatefulWidget {
  const PaymentCardUi({
    Key? key,
    required this.cardHolderFullName,
    required this.cardNumber,
    required this.validThru,
    this.validFrom,
    this.topLeftColor = Colors.purple,
    this.bottomRightColor,
    this.doesSupportNfc = true,
    this.scale = 1.0,
    this.placeNfcIconAtTheEnd = false,
    this.cardType = CardType.credit,
    this.creditCardType,
    this.cardProviderLogo,
    this.cardProviderLogoPosition = CardProviderLogoPosition.right,
    this.backgroundDecorationImage,
    this.showValidFrom = true,
    this.showValidThru = true,
  }) : super(key: key);

  final String cardHolderFullName;
  final String cardNumber;
  final String? validFrom;
  final String validThru;
  final bool showValidFrom;
  final bool showValidThru;
  final Color topLeftColor;
  final Color? bottomRightColor;
  final bool doesSupportNfc;
  final bool placeNfcIconAtTheEnd;
  final double scale;
  final CardType cardType;
  final CreditCardType? creditCardType;
  final Widget? cardProviderLogo;
  final CardProviderLogoPosition cardProviderLogoPosition;
  final DecorationImage? backgroundDecorationImage;

  @override
  State<PaymentCardUi> createState() => _PaymentCardUiState();
}

class _PaymentCardUiState extends State<PaymentCardUi> {
  bool isMasked = true;

  @override
  Widget build(BuildContext context) {
    final cardNumberMasked = CreditCardHelper.maskCreditCardNumber(
      widget.cardNumber.replaceAll(' ', '').replaceAll('-', ''),
    );

    final validFromMasked = widget.validFrom == null
        ? null
        : CreditCardHelper.maskValidity(
            widget.validFrom!,
          );

    final validThruMasked = CreditCardHelper.maskValidity(
      widget.validThru,
    );

    final conditionalBottomRightColor = widget.bottomRightColor ??
        CreditCardHelper.getDarkerColor(
          widget.topLeftColor,
        );

    Widget cardLogoWidget;
    final cardLogoString = CreditCardHelper.getCardLogoFromCardNumber(
      cardNumber: cardNumberMasked,
    );

    if (cardLogoString.isEmpty ||
        widget.creditCardType == CreditCardType.none) {
      cardLogoWidget = const SizedBox.shrink();
    } else if (widget.creditCardType != null) {
      cardLogoWidget = Image.asset(
        CreditCardHelper.getCardLogoFromType(
            creditCardType: widget.creditCardType!),
      );
    } else {
      cardLogoWidget = Image.asset(
        CreditCardHelper.getCardLogoFromCardNumber(
          cardNumber: cardNumberMasked,
        ),
      );
    }

    return InkWell(
      onTap: () {
        setState(() {
          isMasked = !isMasked;
        });
      },
      child: Transform.scale(
        scale: widget.scale,
        child: SizedBox(
          width: 300,
          child: AspectRatio(
            aspectRatio: 1.5789,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.topLeftColor,
                    conditionalBottomRightColor,
                  ],
                ),
                image: widget.backgroundDecorationImage,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 16,
                    child: SizedBox(
                      height: 32,
                      width: 268,
                      child: CreditCardTopLogo(
                        cardType: widget.cardType,
                        cardProviderLogo: widget.cardProviderLogo,
                        cardProviderLogoPosition:
                            widget.cardProviderLogoPosition,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 64,
                    child: CreditCardChipNfcView(
                      doesSupportNfc: widget.doesSupportNfc,
                      placeNfcIconAtTheEnd: widget.placeNfcIconAtTheEnd,
                    ),
                  ),
                  Positioned(
                    top: 138,
                    left: 20,
                    child: CreditCardValidityView(
                      validFromMasked: validFromMasked,
                      validThruMasked: validThruMasked,
                      showValidFrom: widget.showValidFrom,
                      showValidThru: widget.showValidThru,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: SizedBox(
                      height: 36,
                      width: 84,
                      child: AnimatedSwitcher(
                        duration: UiConstants.animationDuration,
                        child: Container(
                          key: ValueKey(cardNumberMasked),
                          child: cardLogoWidget,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 20,
                    child: CreditCardHolderNameView(
                      cardHolderFullName: widget.cardHolderFullName,
                    ),
                  ),
                  Positioned(
                    top: 108,
                    left: 20,
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: Container(
                          key: ValueKey<bool>(isMasked),
                          child: isMasked
                              ? CreditCardText(
                                  cardNumberMasked.length > 20
                                      ? cardNumberMasked.substring(0, 20)
                                      : cardNumberMasked,
                                )
                              : CreditCardText(
                                  widget.cardNumber.length > 20
                                      ? CreditCardHelper.groupDigits(
                                          widget.cardNumber.substring(0, 20))
                                      : CreditCardHelper.groupDigits(
                                          widget.cardNumber),
                                ),
                        )),
                  )
                  // Positioned(
                  //   top: 108,
                  //   left: 20,
                  //   child: isMasked ? CreditCardText(
                  //     cardNumberMasked.length > 20
                  //         ?  cardNumberMasked.substring(0, 20)
                  //         :  cardNumberMasked,
                  //   ) : CreditCardText(
                  //     widget.cardNumber.length > 20
                  //         ? CreditCardHelper.groupDigits( widget.cardNumber.substring(0, 20))
                  //         :  CreditCardHelper.groupDigits(widget.cardNumber),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
