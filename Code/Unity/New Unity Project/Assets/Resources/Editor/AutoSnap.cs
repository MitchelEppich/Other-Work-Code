using UnityEngine;
using UnityEditor;

public class AutoSnap : EditorWindow
{
	private Vector3 prevPosition;
	private bool doSnap = true;
	private bool doRotateUp = false;
	private bool doRotateDown = false;
	private int rotateAngle = 90;
	private float snapValue = 1;
	
	[MenuItem( "Edit/Auto Snap %_l" )]
	
	static void Init()
	{
		var window = (AutoSnap)EditorWindow.GetWindow( typeof( AutoSnap ) );
		window.maxSize = new Vector2( 200, 100 );
	}
	
	public void OnGUI()
	{
		doSnap = EditorGUILayout.Toggle( "Auto Snap", doSnap );
		snapValue = EditorGUILayout.FloatField( "Snap Value", snapValue );
		doRotateUp = EditorGUILayout.Toggle ("Rotate Up", doRotateUp);
		doRotateDown = EditorGUILayout.Toggle ("Rotate Down", doRotateDown);
		rotateAngle = EditorGUILayout.IntField( "Angle Value", rotateAngle );

	}

	public void Update()
	{

		if ( doSnap
		    && !EditorApplication.isPlaying
		    && Selection.transforms.Length > 0
		    && Selection.transforms[0].position != prevPosition )
		{
			Snap();
			prevPosition = Selection.transforms[0].position;
		}

		if (doRotateUp || doRotateDown) {
			Rotate();
			doRotateUp = false;
			doRotateDown = false;
		}
	}


	private void Rotate() {
		foreach ( var transform in Selection.transforms )
		{
			var t = transform.transform.rotation;

			transform.transform.Rotate (RoundR (t.x),
			                            RoundR (t.y),
			                            RoundR (t.z + (doRotateUp ? rotateAngle : -rotateAngle))
			            );
		}
	}

	private void Snap()
	{
		foreach ( var transform in Selection.transforms )
		{
			var t = transform.transform.position;
			t.x = Round( t.x );
			t.y = Round( t.y );
			t.z = Round( t.z );

			transform.transform.position = t;
		}
	}
	
	private float Round( float input )
	{
		return snapValue * Mathf.Round( ( input / snapValue ) );
	}

	private int RoundR(float input) {
		if (input >= 360)
			input -= 360;

		return (int)(rotateAngle * Mathf.Round( ( input / rotateAngle ) ));
	}
}
