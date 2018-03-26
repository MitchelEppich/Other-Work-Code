#pragma once

#include <iostream>
#include <string>

#include "archive.h"

class Structure
{
private:
	std::string debug_mode = "";

public:
	Structure();

	struct sentence
	{
		char punctuation;
		Archive* archive;
	};

	void FillSentence(sentence* def, std::string id, char p, bool isLibrary);

	std::string types[4];

	/*
	Declaractive Sentence :
	- Relay information or ideas
	- Punctuated with a simple period

	Example :
	- The concert begins in two hours.
	- Green is my favourite color.
	- You're a good man, Charlie Brown.
	*/
	sentence declarative;

	/*
	Imperative Sentence :
	- Issue commands or requests or express a desire or wish
	- Punctuated with simple period or exclamations requiring an exclamation mark
	- Depends on strength of emotion to be conveyed
	- Exclamatory can consist of a single verb or more lengthy and complex

	Example :
	- Halt!
	- Yield.
	- Meet me at the town square.
	- Please lower your voice.
	- Drop what you're doing and come celebrate with us!
	*/
	sentence imperative;

	/*
	Exclamatory Sentence :
	- Express strong emotion
	- Not specific to which emotion
	- Always end in an exclamation mark

	Example :
	- The river is rising!
	- I can't wait for the party!
	- Oh, my goodness, I won!
	- Please don't go!
	- This is the best day of my life!
	*/
	sentence exclamatory;

	/*
	Interrogative Sentence :
	- Always ask a question
	- Always end in a question mark

	Example :
	- Is it snowing?
	- Do you want Coke or Pepsi?
	- You like Mexican food, don't you?
	- Have you had breakfast?
	*/
	sentence interrogative;

	int isDefinition(sentence definition, std::string sentence);
	std::string Construct(std::string sentence);
	Bank* Deconstruct(std::string sentence);
	//void Exceptions();

	std::string Aquire();
	std::string Decrypt(std::string sentence);
	bool Review(std::string sentence);

	sentence abbreviation,
		adjective,
		adverb,
		article,
		compound,
		conjunction,
		contraction,
		interjection,
		noun,
		prefix,
		preposition,
		pronoun,
		punctuation,
		suffix,
		verb,
		phrase,
		response;

	std::string GetSignature(std::string data);
	void Record(std::string type, Bank* bank);
	std::string ResponseDatabase(std::string sentence);
};