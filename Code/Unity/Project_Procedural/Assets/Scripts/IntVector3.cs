[System.Serializable]
public struct IntVector3 {

	public int x, y, z;

	public IntVector3 (int x, int y, int z) {
		this.x = x;
        this.y = y;
		this.z = z;
	}

	public static IntVector3 operator + (IntVector3 a, IntVector3 b) {
		a.x += b.x;
        a.y += b.y;
		a.z += b.z;
		return a;
	}
}