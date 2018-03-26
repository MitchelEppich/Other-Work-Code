using UnityEngine;

public enum MazeDirection {
	North,
	East,
	South,
	West
}

public static class MazeDirections {

	public const int Count = 4;

	public static MazeDirection RandomValue {
		get {
			return (MazeDirection)Random.Range(0, Count);
		}
	}

	private static MazeDirection[] opposites = {
		MazeDirection.South,
		MazeDirection.West,
		MazeDirection.North,
		MazeDirection.East
	};

	public static MazeDirection GetOpposite (this MazeDirection direction) {
		return opposites[(int)direction];
	}

	public static MazeDirection GetNextClockwise (this MazeDirection direction) {
		return (MazeDirection)(((int)direction + 1) % Count);
	}

	public static MazeDirection GetNextCounterclockwise (this MazeDirection direction) {
		return (MazeDirection)(((int)direction + Count - 1) % Count);
	}
	
	private static IntVector3[] vectors = {
		new IntVector3(0, 0, 1),
		new IntVector3(1, 0, 0),
		new IntVector3(0, 0, -1),
		new IntVector3(-1, 0, 0)
	};
	
	public static IntVector3 ToIntVector3 (this MazeDirection direction) {
		return vectors[(int)direction];
	}

	private static Quaternion[] rotations = {
		Quaternion.identity,
		Quaternion.Euler(0f, 90f, 0f),
		Quaternion.Euler(0f, 180f, 0f),
		Quaternion.Euler(0f, 270f, 0f)
	};
	
	public static Quaternion ToRotation (this MazeDirection direction) {
		return rotations[(int)direction];
	}
}