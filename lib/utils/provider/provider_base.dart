// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/services/base.dart';
import 'package:findy/utils/services/dio_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:ivms/common_widget/dialog/dialog.dart';
// import 'package:ivms/main.dart';
// import 'package:ivms/util/repositories/base.dart';
// import 'package:ivms/util/services/base.dart';
// import 'package:ivms/util/services/dio_option.dart';
import 'package:provider/provider.dart';

class ConsumerBase<T> extends StatelessWidget {
  final Function(T repository)? onRepository;
  late Function(T repository)? onRepositorySuccess;
  final Function(T repository)? onRepositoryError;
  final Function(T repository)? onRepositoryNoData;
  final Function(T repository)? onRepositoryLoading;

  final BuildContext? contextParrent;

  ConsumerBase({
    super.key,
    this.onRepositorySuccess,
    this.onRepository,
    this.onRepositoryError,
    this.onRepositoryNoData,
    this.onRepositoryLoading,
    this.contextParrent,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (_, T repository, child) {
      BaseRepository rep = repository as BaseRepository<BaseService>;
      if (rep.isLoaded) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParrent ?? _);
        }
        if (onRepositorySuccess != null) {
          return onRepositorySuccess!(repository) ?? Container();
        }
      } else if (rep.loadingFailed) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParrent ?? _);
        }
        if (repository.error == HANDLE401) {
          // _buildAlertRefreshToken(context);
        } else {
          if (onRepositoryError != null) {
            return onRepositoryError!(repository) ?? Container();
          } else {
            return buildNotificationError(repository.error ?? "");
          }
        }
      } else if (rep.isLoading) {
        if (onRepositoryLoading != null) {
          return onRepositoryLoading!(repository) ?? Container();
        } else {
          ProgressLoad.showProgress(contextParrent ?? _);
        }
      } else if (rep.noData) {
        if (onRepositoryLoading == null) {
          ProgressLoad.dismissProgress(contextParrent ?? _);
        }
        if (onRepositoryNoData != null) {
          return onRepositoryNoData!(repository) ?? Container();
        } else {
          return Container(
              color: Colors.transparent,
              child: buildNotificationError("Không có dữ liệu"));
        }
      }
      if (onRepository != null) {
        return onRepository!(repository) ?? Container();
      } else {
        return Container();
      }
    });
  }
}

class SelectorBase<A> extends StatelessWidget {
  final Function(dynamic repository)? onRepository;
  final Function(dynamic repository)? onRepositorySuccess;
  final Function(dynamic repository)? onRepositoryError;
  final Function(dynamic repository)? onRepositoryNoData;
  final BuildContext? contextParent;
  final Function(dynamic repository)? onRepositoryLoading;
  final Status Function(BuildContext, A)
      selector; // (context,provider) => provider.status
  const SelectorBase(
      {super.key,
      required this.selector,
      this.onRepositorySuccess,
      this.onRepositoryError,
      this.onRepositoryNoData,
      this.onRepository,
      this.onRepositoryLoading,
      this.contextParent});

  @override
  Widget build(BuildContext context) {
    return Selector<A, Status>(
      builder: (context, status, child) {
        BaseRepository repository =
            context.read<A>() as BaseRepository<BaseService>;
        if (status == Status.loaded) {
          if (onRepositoryLoading == null) {
            ProgressLoad.dismissProgress(contextParent ?? context);
          }

          if (onRepositorySuccess != null) {
            return onRepositorySuccess!(repository) ?? Container();
          }
        } else if (status == Status.error) {
          if (onRepositoryLoading == null) {
            ProgressLoad.dismissProgress(contextParent ?? context);
          }
          if (repository.error == HANDLE401) {
            // _buildAlertRefreshToken(context);
          } else {
            if (onRepositoryError != null) {
              return onRepositoryError!(repository) ?? Container();
            } else {
              return buildNotificationError(repository.error ?? "");
            }
          }
        } else if (status == Status.loading) {
          if (onRepositoryLoading != null) {
            return onRepositoryLoading!(repository) ?? Container();
          } else {
            ProgressLoad.showProgress(contextParent ?? context);
          }
        } else if (status == Status.noData) {
          if (onRepositoryLoading == null) {
            ProgressLoad.dismissProgress(contextParent ?? context);
          }
          if (onRepositoryNoData != null) {
            return onRepositoryNoData!(repository) ?? Container();
          } else {
            return Container(
                color: Colors.white,
                child: buildNotificationError("Không có dữ liệu"));
          }
        }
        if (onRepository != null) {
          return onRepository!(repository) ?? Container();
        } else {
          return Container();
        }
      },
      selector: selector,
    );
  }
}

class ProgressLoad {
  /// Custom Notification
  static showProgress(BuildContext context, {String? content}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progress = ProgressHUD.of(context);
      progress?.showWithText(content ?? "Đang tải dữ liệu...");
    });
  }

  static dismissProgress(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progress = ProgressHUD.of(context);
      progress?.dismiss();
    });
  }
}

Container buildNotificationError(String textError) {
  return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Center(
        child: Text(
          textError,
          textAlign: TextAlign.center,
        ),
      ));
}

// void _buildAlertRefreshToken(BuildContext context) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     AppDialog.showResultDialog(
//         context: navigatorKey.currentContext!,
//         success: false,
//         message: "Đổi mật khẩu thành công!",
//         btnText: "Xác nhận",
//         callbackBtn: () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, '/aicam_login', (route) => false);
//         });
//   });
// }
