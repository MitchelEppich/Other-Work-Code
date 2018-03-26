using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Controls : MonoBehaviour {

    public GameObject[] boxes;
    public KeyCode[] keys = { KeyCode.UpArrow, KeyCode.RightArrow, KeyCode.DownArrow, KeyCode.LeftArrow };
    public GameObject textObject;
    public GameObject scoreObject;

    Queue<IEnumerator> stack = new Queue<IEnumerator>();
    List<int> pattern = new List<int>();
    List<int> input = new List<int>();

    int selection = -1;

    int round = 0;
    float roundSpeedChange = 0.1f;

    int roundScore = 0;
    int score = 0;
    int multiplier = 0;
    float currentTime = 0;
    float lastTime = 0;

    int pointPerClick = 100;
    int bonusMultiplier = 5;
    int roundBonus = 500;

    bool isBusy = false;
    bool archived = false;
    bool ingame = false;

    void Update()
    {
        if (ingame)
            goto Running;

        round++;

        // Create pattern
        stack.Enqueue(GeneratePattern());

        // Show pattern
        /// Wipe Board
        /// Warn player
        /// Start showing pattern
        stack.Enqueue(ClearBoard());
        stack.Enqueue(ShowText("WATCH", 2));
        stack.Enqueue(ShowPattern());

        // Player attempts pattern
        /// Wipe board
        /// Warn player
        /// Allow player to attempt
        /// Deal with outcome
        stack.Enqueue(ClearBoard());
        stack.Enqueue(ShowText("YOUR TURN", 1.5f));
        stack.Enqueue(AttemptPattern());

        // Restart
        /// Save score
        /// Go back to start
        //Save();
        ingame = true;

    Running:
        //Debug.Log("Running : " + stack.Count);

        if (!isBusy)
        {
            ExecuteStack();
        }

        if (stack.Count == 0)
            ingame = false;

        score += roundScore;

    }

    void ExecuteStack()
    {
        StartCoroutine(stack.Dequeue());
    }

    IEnumerator GeneratePattern()
    {
        isBusy = true;

        pattern.Clear();

        Random.seed = Random.Range(0, 100000);

        float min = Mathf.Min(2f + ((float)round / 2f), 10f);
        float max = Mathf.Min(3f + (float)round, 10f);
        Debug.Log((int)min + " " + (int)max);
        int size = Random.Range((int)min, (int)max);

        for (int i = 0; i < size; i++)
        {
            pattern.Add(Random.Range(0, 3));
        }

        isBusy = false;
        yield return null;
    }

    IEnumerator ClearBoard()
    {
        isBusy = true;

        int i = 0;

        foreach (KeyCode k in keys)
            boxes[i++].GetComponent<Renderer>().enabled = false;

        isBusy = false;

        yield return null;
    }

    IEnumerator ShowText(string text, float size)
    {
        isBusy = true;

        textObject.GetComponent<TextMesh>().text = text;
        textObject.GetComponent<TextMesh>().characterSize = size / 10;
        textObject.SetActive(true);
        yield return new WaitForSeconds(2);
        textObject.SetActive(false);

        isBusy = false;
    }

    IEnumerator ShowPattern()
    {
        isBusy = true;

        int i = 0;

    PatternNotComplete:
        Renderer box = boxes[pattern[i++]].GetComponent<Renderer>();

        // Wait between every segment
        yield return new WaitForSeconds(Mathf.Max(2f - (round * roundSpeedChange), 0.2f));

        box.enabled = true;

        // Allow the segment to show
        yield return new WaitForSeconds(Mathf.Max(2f - (round * roundSpeedChange), 0.2f));

        box.enabled = false;

        if (i < pattern.Count)
            goto PatternNotComplete;

        isBusy = false;
    }

    IEnumerator AttemptPattern()
    {
        isBusy = true;
        int i = 0;

        foreach (KeyCode k in keys)
        {
            if (selection == i && !Input.GetKey(k))
            {
                boxes[selection].GetComponent<Renderer>().enabled = false;
                selection = -1;
                archived = false;
            }

            if (selection == -1 && Input.GetKey(k))
            {
                selection = i;
                break;
            }
            i++;
        }

        if (selection != -1 && !archived)
        {
            boxes[selection].GetComponent<Renderer>().enabled = true;
            input.Add(selection);
            archived = true;


            if (input[input.Count - 1] == pattern[input.Count - 1])
            {
                ScoreKeeper();

                if (input.Count == pattern.Count)
                {
                    isBusy = false;
                    boxes[selection].GetComponent<Renderer>().enabled = false;
                    stack.Enqueue(ShowText("SUCCESS", 2));
                    // Show positive

                    // Clear up for next round
                    input.Clear();
                    archived = false;

                    roundScore += roundBonus;
                }
                else
                {
                    isBusy = false;
                    stack.Enqueue(AttemptPattern());
                }
            }
            else
            {
                isBusy = false;
                boxes[selection].GetComponent<Renderer>().enabled = false;
                stack.Enqueue(ShowText("FAILURE", 2));
                // Show failure

                // Clear up for next round
                input.Clear();
                archived = false;
            }
        }
        else
        {
            isBusy = false;
            stack.Enqueue(AttemptPattern());
        }

        yield return null;
    }

    void ScoreKeeper()
    {
        float tempScore = 1;

        // Acquire current time
        currentTime = Time.time;

        if (lastTime != 0)
        {
            float elapsedTime = currentTime - lastTime;

            if (elapsedTime <= 10f)
                multiplier++;
            else
                multiplier = 1;

            if (elapsedTime <= 5f)
                tempScore *= bonusMultiplier;
        }
        else multiplier = 1;

        tempScore *= pointPerClick * multiplier;

        // Present temp score

        roundScore += (int) tempScore;

        // Update round score
        scoreObject.GetComponent<TextMesh>().text = roundScore.ToString();

        // Prepare for future
        lastTime = currentTime;
    }
}
