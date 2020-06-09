import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mooncake/ui/ui.dart';
import 'package:password_strength/password_strength.dart';

/// Represents a generic state for the screen that allows the user to view
/// his own mnemonic.
@immutable
class MnemonicState extends Equatable {
  final bool showMnemonic;
  final List<String> mnemonic;

  MnemonicState({
    @required this.showMnemonic,
    @required this.mnemonic,
  })  : assert(showMnemonic != null),
        assert(mnemonic != null);

  factory MnemonicState.initial() {
    return MnemonicState(
      showMnemonic: false,
      mnemonic: [],
    );
  }

  MnemonicState copyWith({
    bool showMnemonic,
    List<String> mnemonic,
  }) {
    return MnemonicState(
      showMnemonic: showMnemonic ?? this.showMnemonic,
      mnemonic: mnemonic ?? this.mnemonic,
    );
  }

  @override
  String toString() => 'MnemonicState { '
      'showMnemonic: $showMnemonic '
      ' }';

  @override
  List<Object> get props {
    return [
      showMnemonic,
      mnemonic,
    ];
  }
}

/// Represents the mnemonic screen state during which the user has decided
/// to export his mnemonic and should specify the password with which to
/// encrypt it.
@immutable
class ExportingMnemonic extends MnemonicState {
  final String encryptPassword;
  final bool exportingMnemonic;

  /// Indicates the security of the password.
  PasswordSecurity get passwordSecurity {
    if (encryptPassword == null) {
      return PasswordSecurity.UNKNOWN;
    }

    final strength = estimatePasswordStrength(encryptPassword);
    PasswordSecurity security = PasswordSecurity.UNKNOWN;
    if (strength < 0.50) {
      security = PasswordSecurity.LOW;
    } else if (strength < 0.75) {
      security = PasswordSecurity.MEDIUM;
    } else {
      security = PasswordSecurity.HIGH;
    }
    return security;
  }

  /// Tells whenever the export can be enabled or not.
  bool get enableExport {
    return passwordSecurity == PasswordSecurity.MEDIUM ||
        passwordSecurity == PasswordSecurity.HIGH;
  }

  ExportingMnemonic({
    @required this.encryptPassword,
    @required this.exportingMnemonic,
    @required bool showMnemonic,
    @required List<String> mnemonic,
  })  : assert(exportingMnemonic != null),
        super(mnemonic: mnemonic, showMnemonic: showMnemonic);

  factory ExportingMnemonic.fromMnemonicState(MnemonicState state) {
    return ExportingMnemonic(
      encryptPassword: null,
      exportingMnemonic: false,
      showMnemonic: state.showMnemonic,
      mnemonic: state.mnemonic,
    );
  }

  @override
  ExportingMnemonic copyWith({
    bool showMnemonic,
    List<String> mnemonic,
    String encryptPassword,
    bool exportingMnemonic,
  }) {
    return ExportingMnemonic(
      showMnemonic: showMnemonic ?? this.showMnemonic,
      mnemonic: mnemonic ?? this.mnemonic,
      encryptPassword: encryptPassword ?? this.encryptPassword,
      exportingMnemonic: exportingMnemonic ?? this.exportingMnemonic,
    );
  }

  @override
  String toString() => 'ExportingMnemonic { '
      'encryptPassword: $encryptPassword, '
      'exportingMnemonic: $exportingMnemonic '
      ' }';

  @override
  List<Object> get props {
    return super.props +
        [
          encryptPassword,
          exportingMnemonic,
        ];
  }
}