using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class Structure_Builder : EditorWindow {

    // House Creation
    string structureName = "";
    bool doEdit = false;

    GameObject current;
    Object currentPrefab;

    float levels = 0;
    float lastLevel = 0;
    float currentLevel = 0;

    bool autoAdd = true;

    bool structureExists = false;
    string outcome;

    public Transform baseModel;

    // Editing
    private Vector3 prevPosition;
    private bool doSnap = true;
    //private bool doSize = true;
    private bool doRotateUp = false;
    private bool doRotateDown = false;
    private int rotateAngle = 90;
    private float snapValue = 1;

    private bool autoFocus = false;

    private float floorHeight = 1f - 0.028f;

    Vector2 scrollPos;
    List<GameObject> objs = new List<GameObject>();
    List<string> database_cache = new List<string>();
    private bool addNewItem = false;
    int selected = 0;
    string elementName = "";
    GameObject element = null;


    /////////

    [MenuItem("GameObject/Create Structure...")]

    static void Init()
    {
        var window = (Structure_Builder)EditorWindow.GetWindow(typeof(Structure_Builder));
        window.maxSize = new Vector2(200, 100);
    }

    public void OnGUI()
    {

        structureExists = Resources.Load("Prefabs/Structures/" + structureName, typeof(Transform)) as Transform != null;

        if (structureExists)
            currentPrefab = Resources.Load("Prefabs/Structures/" + structureName, typeof(GameObject)) as GameObject;

        if (doEdit)
        {
            currentLevel = Mathf.Floor(EditorGUILayout.Slider(currentLevel, 1f, 100f));
            autoAdd = EditorGUILayout.Toggle("Automatically Add...", autoAdd);
            levels = Mathf.Floor(EditorGUILayout.Slider(levels, 1f, 100f));


            doSnap = EditorGUILayout.Toggle("Auto Snap", doSnap);
            autoFocus = EditorGUILayout.Toggle("Auto Focus", autoFocus);

            floorHeight = EditorGUILayout.FloatField("Room Height", floorHeight);

            //doSize = EditorGUILayout.Toggle ("Auto Size", doSize);
            snapValue = EditorGUILayout.FloatField("Snap Value", snapValue);
            rotateAngle = EditorGUILayout.IntField("Angle Value", rotateAngle);

            if(GUILayout.Button("Rotate Up"))
            {
                doRotateUp = true;
                Rotate();
            }

            if (GUILayout.Button("Rotate Down"))
            {
                doRotateDown = true;
                Rotate();
            }

            if (GUILayout.Button("Save Prefab..."))
            {
                SaveStructPrefab();
            }

            if (GUILayout.Button("Create Another Structure..."))
                ResetScene();

            if (!addNewItem)
                if (GUILayout.Button("Add Element To Database..."))
                    addNewItem = true;


            if (addNewItem)
            {
                elementName = EditorGUILayout.TextField("Name", elementName);
                element = EditorGUILayout.ObjectField("Element", element, typeof(GameObject), false) as GameObject;

                if (GUILayout.Button("Create Element..."))
                {
                    SaveElementPrefab();

                    //ResetElementDB();

                    ResetElementCreation();
                }
            }

            selected = EditorGUILayout.Popup(selected, database_cache.ToArray());


        }
        else {
            structureName = EditorGUILayout.TextField("Structure ID", structureName);
            GUI.SetNextControlName("Clear");

            if (structureExists)
            {
                baseModel = Resources.Load("Prefabs/Structures/" + structureName, typeof(Transform)) as Transform;
            }
            else {
                baseModel = Resources.Load("Prefabs/Structures/BaseModel", typeof(Transform)) as Transform;
            }

            outcome = (!structureExists ? "Design Structure" : "Edit Structure");

            if (GUILayout.Button(outcome) && !string.IsNullOrEmpty(structureName))
            {

                EditorApplication.NewScene();

                if (baseModel != null)
                {
                    Object obj = Instantiate(baseModel, baseModel.position, baseModel.rotation);
                    obj.name = obj.name.Replace("(Clone)", "");
                }

                GUI.FocusControl("Clear");
                GUI.FocusControl(null);
                if (!structureExists)
                {
                    current = new GameObject();
                    current.name = structureName;
                }
                else {
                    current = baseModel.gameObject;
                    Selection.activeGameObject = GameObject.Find(structureName);
                    SceneView.lastActiveSceneView.FrameSelected();

                    levels = lastLevel = currentLevel = current.transform.childCount;
                }

                doEdit = true;
            }
        }

    }

    public void OnEnabe()
    {
        SceneView.onSceneGUIDelegate += OnScene;
    }


    private static void OnScene(SceneView sceneview)
    {
        Debug.Log("This event opens up so many possibilities.");
    }

    public void OnDisable()
    {
        SceneView.onSceneGUIDelegate -= OnScene;
    }

    void OnSceneGUI()
    {
        // Editor Controls

        if (Event.current.keyCode == KeyCode.X)
        {
            Event.current.Use();
            Debug.Log("Caught");
        }

        if (Event.current.type == EventType.MouseDown)
            Debug.Log("Mouse Clicked");
    }

    public void Update()
    {

        if (doEdit && current != null)
        {

            if (Selection.activeGameObject != null && Selection.activeGameObject.transform.position.y > floorHeight * currentLevel ||
               Selection.activeGameObject != null && Selection.activeGameObject.transform.position.y < floorHeight * currentLevel)
            {


                float temp = Mathf.Round((Selection.activeGameObject.transform.position.y / floorHeight) + 1f);
                GameObject level = null;

                if (levels < temp)
                {
                    levels += temp - levels;
                    currentLevel = levels;
                    for (int i = 0; i < temp - levels; i++)
                    {
                        level = AddLevel((int)(i + levels));
                    }
                }
                else {
                    currentLevel = temp;
                    if (autoFocus)
                        SceneView.lastActiveSceneView.FrameSelected();
                    level = GameObject.Find(current.name + "/Level " + temp);
                }

                if (Selection.activeGameObject != null && level != null && !Selection.activeGameObject.name.Contains("Level"))
                {
                    foreach (var transform in Selection.transforms)
                    {
                        transform.parent = level.transform;
                    }
                }
            }
            //
            //			if(doSize && Selection != null)
            //				snapValue = Selection.activeGameObject.GetComponent<Renderer>().bounds.extents.y;

            // Transfer base to main
            if (GameObject.Find("BaseModel") != null && structureName != "BaseModel")
            {
                int temp = GameObject.Find("BaseModel").transform.childCount;
                for (int i = 0; i < temp; i++)
                {
                    if (GameObject.Find(current.name + "Level " + (i + 1)) == null)
                    {
                        AddLevel(i + 1);
                    }

                    if (GameObject.Find("BaseModel/Level " + (i + 1)) != null)
                    {
                        Transform[] allChildren = GameObject.Find("BaseModel/Level " + (i + 1)).GetComponentsInChildren<Transform>();
                        foreach (Transform child in allChildren)
                        {
                            child.parent = GameObject.Find(current.name + "/Level " + (i + 1)).transform;
                        }
                        DestroyImmediate(GameObject.Find("BaseModel/Level " + (i + 1)));
                    }
                    else if (GameObject.Find("BaseModel") != null &&
                            GameObject.Find("BaseModel").transform.childCount == 0)
                    {
                        DestroyImmediate(GameObject.Find("BaseModel"));
                    }

                }
            }

            //////

            for (int i = 0; i < levels; i++)
            {

                if (i + 1 == levels)
                {
                    for (int y = 0; y < lastLevel - levels; y++)
                    {
                        DestroyImmediate(GameObject.Find(current.name + "/Level " + (y + levels + 1)));
                    }

                    lastLevel = (int)levels;
                }
                if (GameObject.Find(current.name + "/Level " + (i + 1)) != null)
                    continue;

                AddLevel(i + 1);
                lastLevel += 1;
            }

            if (currentLevel > levels)
                currentLevel = levels;


            if (doSnap
                && !EditorApplication.isPlaying
                && Selection.transforms.Length > 0
                && Selection.transforms[0].position != prevPosition)
            {
                Snap();
                prevPosition = Selection.transforms[0].position;
            }

            if (doRotateUp || doRotateDown)
            {
                Rotate();
                doRotateUp = false;
                doRotateDown = false;
            }

            else {
                for (int i = 0; i < levels; i++)
                {
                    Renderer[] ChildrenRenderer = GameObject.Find(current.name + "/Level " + (i + 1)).GetComponentsInChildren<Renderer>() as Renderer[];

                    if (i < currentLevel)

                        foreach (Renderer rend in ChildrenRenderer)
                            rend.enabled = true;
                    else

                        foreach (Renderer rend in ChildrenRenderer)
                            rend.enabled = false;
                }
            }

            if (Selection.activeTransform != null && autoAdd && !Selection.activeGameObject.name.Contains("Level"))
                Selection.activeTransform.parent = GameObject.Find(current.name + "/Level " + (currentLevel)).transform;
        }
    }

    private void SaveElementPrefab()
    {
        Debug.Log(elementName);
        Debug.Log(element.name);

        objs.Add(element);

        //GameObject item = Instantiate(element);

        Object elementPrefab = PrefabUtility.CreateEmptyPrefab("Assets/Resources/Prefabs/Element_Database/" + elementName + ".prefab");
        PrefabUtility.ReplacePrefab(element, elementPrefab, ReplacePrefabOptions.ConnectToPrefab);

        database_cache.Add(elementName);
    }

    private void ResetElementDB()
    {
        objs = new List<GameObject>();
        database_cache = new List<string>();
    }

    private void ResetElementCreation()
    {
        addNewItem = false;
        element = null;
        elementName = "";
    }

    private void SaveStructPrefab()
    {
        for (int i = 0; i < levels; i++)
        {
            Renderer[] ChildrenRenderer = GameObject.Find(current.name + "/Level " + (i + 1)).GetComponentsInChildren<Renderer>() as Renderer[];

            foreach (Renderer rend in ChildrenRenderer)
                rend.enabled = true;
        }

        currentPrefab = PrefabUtility.CreateEmptyPrefab(currentPrefab != null ? AssetDatabase.GetAssetPath(currentPrefab) : "Assets/Resources/Prefabs/Structures/" + structureName + ".prefab");
        current = GameObject.Find(structureName);
        PrefabUtility.ReplacePrefab(current, currentPrefab, ReplacePrefabOptions.ConnectToPrefab);
    }

    private void ResetScene()
    {
        current = null;
        baseModel = null;
        currentPrefab = null;
        levels = 0;
        lastLevel = 0;
        currentLevel = 0;
        autoAdd = true;
        structureName = "";
        doEdit = false;
    }

    private GameObject AddLevel(int id)
    {
        GameObject obj = new GameObject();
        obj.name = "Level " + (id);
        obj.transform.parent = GameObject.Find(structureName).transform;

        return obj;
    }

    private void Rotate()
    {
        foreach (var transform in Selection.transforms)
        {
            var t = transform.transform.rotation;

            transform.transform.Rotate(RoundR(t.x),
                                        RoundR(t.y),
                                        RoundR(t.z + (doRotateUp ? rotateAngle : -rotateAngle))
                                        );
        }
    }

    private void Snap()
    {
        foreach (var transform in Selection.transforms)
        {
            var t = transform.transform.position;
            t.x = Round(t.x);
            t.y = Round(t.y);
            t.z = Round(t.z);

            transform.transform.position = t;
        }
    }

    private float Round(float input)
    {
        return snapValue * Mathf.Round((input / snapValue));
    }

    private int RoundR(float input)
    {
        if (input >= 360)
            input -= 360;

        return (int)(rotateAngle * Mathf.Round((input / rotateAngle)));
    }
}
