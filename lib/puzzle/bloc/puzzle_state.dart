// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum PuzzleStatus { incomplete, complete, reversing, reversed, spam }

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.puzzleProcess = const <int>[],
    this.puzzleStatus = PuzzleStatus.incomplete,
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfCorrectTiles = 0,
    this.prevNumberOfCorrectTiles = 0,
    this.numberOfMoves = 0,
    this.playerScore = 0,
    this.lastTappedTile,
    this.customPuzzleChange = false,
  });

  /// [customPuzzleChange] State to trigger image change on custom page
  final customPuzzleChange;

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// [List<int>] containing the current tile arrangement.
  final List<int> puzzleProcess;

  /// Status indicating the current state of the puzzle.
  final PuzzleStatus puzzleStatus;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Represents the last tapped tile of the puzzle.
  ///
  /// The value is `null` if the user has not interacted with
  /// the puzzle yet.
  final Tile? lastTappedTile;

  /// Number of tiles currently in their correct position.
  final int numberOfCorrectTiles;

  final int prevNumberOfCorrectTiles;

  /// Player Score
  final int playerScore;

  /// Number of tiles currently not in their correct position.
  int get numberOfTilesLeft => puzzle.tiles.length - numberOfCorrectTiles - 1;

  /// Number representing how many moves have been made on the current puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  PuzzleState copyWith({
    Puzzle? puzzle,
    PuzzleStatus? puzzleStatus,
    TileMovementStatus? tileMovementStatus,
    int? numberOfCorrectTiles,
    int? prevNumberOfCorrectTiles,
    int? numberOfMoves,
    int? playerScore,
    Tile? lastTappedTile,
    bool? customPuzzleChange,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      puzzleStatus: puzzleStatus ?? this.puzzleStatus,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfCorrectTiles: numberOfCorrectTiles ?? this.numberOfCorrectTiles,
      prevNumberOfCorrectTiles:
          prevNumberOfCorrectTiles ?? this.prevNumberOfCorrectTiles,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      playerScore: playerScore ?? this.playerScore,
      lastTappedTile: lastTappedTile ?? this.lastTappedTile,
      customPuzzleChange: customPuzzleChange ?? this.customPuzzleChange,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        puzzleStatus,
        tileMovementStatus,
        numberOfCorrectTiles,
        prevNumberOfCorrectTiles,
        numberOfMoves,
        playerScore,
        lastTappedTile,
        customPuzzleChange,
      ];
}
