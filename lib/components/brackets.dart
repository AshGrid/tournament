import 'package:flutter/material.dart';


import '../dep/lib/src/model/tournament_match.dart';
import '../dep/lib/src/model/tournament_model.dart';
import '../dep/lib/src/utils/calculate_seperator_height.dart';
import 'bracketCard.dart';


/// A widget that displays a tournament bracket.
///
/// The [TournamentBracket] widget arranges a list of matches in a tournament format,
/// with lines connecting the matches to indicate progression.
///
/// The widget supports zooming and panning for better visibility.
class TournamentBracket extends StatelessWidget {
  /// Creates a [TournamentBracket] widget.
  ///
  /// The [list] parameter must not be null.
  const TournamentBracket({
    super.key,
    this.itemsMarginVertical = 20.0,
    this.cardHeight = 100.0,
    this.cardWidth = 220.0,
    this.card,
    required this.list,
    this.lineColor = Colors.green,
  });

  /// The vertical margin between items in the bracket.
  final double itemsMarginVertical;

  /// The height of each match card.
  final double cardHeight;

  /// The width of the lines connecting the matches.
  final double cardWidth;

  /// A custom widget for the match card. If not provided, a default card is used.
  final Widget Function(TournamentMatch match)? card;

  /// The color of the lines connecting the matches.
  final Color lineColor;

  /// A list representing the matches in the tournament.
  /// Each element should have a `matches` property indicating the number of matches.
  final List<Tournament> list;

  @override
  Widget build(BuildContext context) {
    double separatorH = itemsMarginVertical;
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 2.0,
      boundaryMargin: const EdgeInsets.all(100),
      constrained: false,
      child: SizedBox(
        height: ((list.first.matches.length * cardHeight) +
            ((list.first.matches.length - 1) * separatorH) +
            200),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, index) {
            final Tournament item = list[index];
            separatorH = calculateSeparatorHeight(
                groupsSize: index,
                itemsMarginVertical: itemsMarginVertical,
                cardHeight: cardHeight);
            return _MatchesList(
              cardWidth: cardWidth,
              cardHeight: cardHeight,
              card: card,
              matchCount: item.matches.length,
              separatorHeight: separatorH,
              matches: item.matches,
            );
          },
          separatorBuilder: (_, index) {
            final Tournament item = list[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 80.0,
                    child: ListView.separated(
                      itemCount: item.matches.length ~/ 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: (separatorH + cardHeight),
                              width: 40.0,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: lineColor, width: 2),
                                      right: BorderSide(
                                          color: lineColor, width: 2),
                                      bottom: BorderSide(
                                          color: lineColor, width: 2))),
                            ),
                            Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: lineColor,
                                ))
                          ],
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: (cardHeight + separatorH),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



/// A widget that displays a list of matches.
///
/// The [_MatchesList] widget arranges match cards in a vertical list with separators between them.
class _MatchesList extends StatelessWidget {
  /// Creates a [_MatchesList] widget.
  const _MatchesList({
    super.key,
    required this.matchCount,
    required this.separatorHeight,
    this.cardHeight = 100.0,
    this.cardWidth = 220.0,
    this.card,
    required this.matches,
  });

  /// The number of matches to be displayed.
  final int matchCount;

  /// The height of the separator between match cards.
  final double separatorHeight;

  /// The height of each match card.
  final double? cardHeight;

  /// The width of the lines connecting the matches.
  final double? cardWidth;

  /// A custom widget for the match card. If not provided, a default card is used.
  final Widget Function(TournamentMatch match)? card;

  final List<TournamentMatch> matches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth ?? 220.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ListView.separated(
              itemCount: matches.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final TournamentMatch item = matches[index];

                return SizedBox(
                    height: cardHeight ?? 100.0,
                    child: card != null
                        ? card!(item)
                        : BracketMatchCard(
                      item: item,
                    ));
              },
              separatorBuilder: (_, int index) {
                return Container(
                  height: separatorHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
