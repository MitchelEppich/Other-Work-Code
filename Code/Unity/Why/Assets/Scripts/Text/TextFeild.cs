using UnityEngine;
using UnityEditor;
using System.Collections;

public class TextFeild : ScriptableWizard {

    public string text;

    public GameObject[] charsModels = Resources.LoadAll<UnityEngine.GameObject>("/Prefabs/Characters");

    private string[] chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "!", "@", "$", "#", "%", "&", "(", ")", "/", "\\", ".", "?", ",", "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " "};

    [MenuItem("GameObject/Create Other/3D Text...")]
    static void CreateWizard()
    {
        ScriptableWizard.DisplayWizard("Text Field", typeof(TextFeild));
    }

    void OnWizardCreate()
    {
        UpdateText();
    }

    int FindLetterIndex(char character)
    {
        for (int i = 0; i < chars.Length; i++)
        {
            if (chars[i].Equals(character.ToString().ToUpper()))
            {
                return i;
            }
        }
        return 0;
    }

    void UpdateText()
    {

        UnityEngine.GameObject parent = new GameObject(text);
        parent.transform.position = Vector3.zero;

        for (int i = 0; i < text.Length; i++)
        {
            int index = FindLetterIndex(text[i]);

            UnityEngine.Object prefab = UnityEditor.PrefabUtility.InstantiatePrefab(charsModels[index]);
            UnityEngine.GameObject newChar = (UnityEngine.GameObject)prefab;
            newChar.transform.parent = parent.transform;
            newChar.transform.position = new Vector3(parent.transform.position.x + i, parent.transform.position.y, parent.transform.position.z);
            newChar.GetComponent<Reveal>().startZ = parent.transform.position.z;
        }
    }

}
