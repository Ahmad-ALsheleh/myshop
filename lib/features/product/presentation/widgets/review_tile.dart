import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/models/review.dart';
import 'rating_stars.dart';

/// One review: author, stars, date, text, "Comment" and "Helpful".
class ReviewTile extends StatefulWidget {
  const ReviewTile({super.key, required this.review});

  final Review review;

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  var _markedHelpful = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final review = widget.review;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final helpfulCount = review.helpfulCount + (_markedHelpful ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          review.authorName,
          style: AppTextStyles.body.copyWith(
            color: palette.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            RatingStars(
              rating: review.rating.toDouble(),
              size: ShopDimens.productStar,
              spacing: 0,
            ),
            const Spacer(),
            Text(
              DateFormat.yMMMMd(locale).format(review.date),
              style: AppTextStyles.footnote.copyWith(color: palette.textBody),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          context.localize(review.text),
          style: AppTextStyles.body.copyWith(color: palette.textBody),
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          l10n.helpfulCount(helpfulCount),
          style: AppTextStyles.footnote.copyWith(color: palette.textSecondary),
        ),
        const SizedBox(height: AppSpacing.s),
        Row(
          children: [
            GestureDetector(
              onTap: () => showCommentSheet(context),
              child: Text(
                l10n.comment,
                style: AppTextStyles.body.copyWith(
                  color: palette.textPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: palette.textPrimary,
                ),
              ),
            ),
            const Spacer(),
            Semantics(
              button: true,
              toggled: _markedHelpful,
              child: GestureDetector(
                onTap: () => setState(() => _markedHelpful = !_markedHelpful),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      l10n.helpful,
                      style: AppTextStyles.footnote.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                    Icon(
                      _markedHelpful ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: AppSizes.icon,
                      color: _markedHelpful
                          ? palette.accent
                          : palette.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// All the reviews of a product ("See All").
Future<void> showReviewsSheet(BuildContext context, List<Review> reviews) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (context, controller) => ListView.separated(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.m,
          0,
          AppSpacing.m,
          AppSpacing.l,
        ),
        itemCount: reviews.length + 1,
        separatorBuilder: (_, index) => index == 0
            ? const SizedBox(height: AppSpacing.m)
            : const Divider(height: AppSpacing.xl),
        itemBuilder: (context, index) => index == 0
            ? Text(
                context.l10n.reviews,
                style: AppTextStyles.headline.copyWith(
                  color: context.palette.textPrimary,
                ),
              )
            : ReviewTile(review: reviews[index - 1]),
      ),
    ),
  );
}

/// Small reactive form to write a comment on a review.
Future<void> showCommentSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _CommentSheet(),
  );
}

class _CommentSheet extends StatefulWidget {
  const _CommentSheet();

  @override
  State<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<_CommentSheet> {
  static const _comment = 'comment';

  final _form = FormGroup({
    _comment: FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
  });

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _send() {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final thanks = context.l10n.commentThanks;
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(thanks)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.m,
        0,
        AppSpacing.m,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.m,
      ),
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.m,
          children: [
            AppTextField<String>(
              formControlName: _comment,
              hintText: l10n.writeComment,
              autofocus: true,
              textInputAction: TextInputAction.send,
            ),
            PrimaryButton(label: l10n.send, onPressed: _send),
          ],
        ),
      ),
    );
  }
}
