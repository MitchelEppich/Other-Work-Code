using UnityEngine;
using System.Collections;

public class WriteAnEssay : MonoBehaviour {

    public TextMesh textmesh;
    public string text;
    public string inputText;
    private int letterCount;

	void Awake ()
    {
        textmesh = gameObject.AddComponent<TextMesh>();
        text = "Hey how are you and i am the boss of this house and i like to eat food time to time because i am the best person in the best.";

    }

    void Update()
    {
        //text = "Hey how are you and i am the boss of this house and i like to eat food time to time because i am the best person in the best.";
        //text += Input.inputString;
        //textmesh.text = text;

        // Edit input text
        string inputLetter = Input.inputString;
        string phrase = text.Substring(letterCount);

        Debug.Log(inputLetter + " " + phrase);

        if (inputLetter != "" && phrase.StartsWith(inputLetter))
        {
            inputText += Input.inputString;
            letterCount++;
        }
        else Debug.Log("Boop");

        // Display input text
        textmesh.text = inputText;

    }
}
