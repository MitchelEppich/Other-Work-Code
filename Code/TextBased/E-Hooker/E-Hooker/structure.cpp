#include <iostream>
#include <string>
#include <algorithm>

#include "structure.h"
#include "system.h"



Structure::Structure()
{
	types[0] = "declarative";
	types[1] = "imperative";
	types[2] = "exclamatory";
	types[3] = "interrogative";

	FillSentence(&declarative, types[0], '.', false);
	FillSentence(&imperative, types[1], '.', false);
	FillSentence(&exclamatory, types[2], '!', false);
	FillSentence(&interrogative, types[3], '?', false);

	FillSentence(&abbreviation, "abbreviation", ' ', true);
	FillSentence(&adjective, "adjective", ' ', true);
	FillSentence(&adverb, "adverb", ' ', true);
	FillSentence(&article, "article", ' ', true);
	FillSentence(&compound, "compound", ' ', true);
	FillSentence(&contraction, "contraction", ' ', false);
	FillSentence(&conjunction, "conjunction", ' ', true);
	FillSentence(&interjection, "interjection", ' ', true);
	FillSentence(&noun, "noun", ' ', true);
	FillSentence(&prefix, "prefix", ' ', true);
	FillSentence(&preposition, "preposition", ' ', true);
	FillSentence(&pronoun, "pronoun", ' ', true);
	FillSentence(&punctuation, "punctuation", ' ', true);
	FillSentence(&suffix, "suffix", ' ', true);
	FillSentence(&verb, "verb", ' ', true);

	FillSentence(&response, "response", ' ', true);
	FillSentence(&phrase, "phrase", ' ', true);
}

void Structure::FillSentence(sentence* def, std::string id, char p, bool isLibrary)
{
	def->punctuation = p;
	
	def->archive = new Archive(id, isLibrary);
}

std::string Structure::Decrypt(std::string sentence)
{
	System* system = new System();
	std::string type;

	int decision[] = 
	{
		isDefinition(declarative, sentence), 
		isDefinition(imperative, sentence),
		isDefinition(exclamatory, sentence),
		isDefinition(interrogative, sentence)
	};

	int peak = decision[system->MaxIndex(decision, 4)];

	if (Review(sentence))
		return "";

	if (peak == 0 || debug_mode == "build:enable") type = Aquire();
	else for (int i = 0; i < 4; i++) if (decision[i] == peak) type += types[i];

	return type;
}

int Structure::isDefinition(sentence definition, std::string sentence)
{
	int chance = 0;
	std::string word = "";
	
	for (int i = 0; i < sentence.length(); i++)
	{
		char letter = sentence[i];
		if (letter == ' ' || letter == '!' || letter == '.' || letter == '?')
		{
			transform(word.begin(), word.end(), word.begin(), (int (*)(int))tolower);
			for (int x = 0; x < definition.archive->Length(); x++)
			{
				if (definition.archive->GetBankAt(x) == word)
				{
					chance++;
				}
			}
			word = "";
		} 
		else word += letter;
	}

	if (sentence[sentence.length() - 1] == definition.punctuation)
		chance += 10;

	return chance;
}

std::string Structure::Aquire()
{
	int choice;

	std::cout << "Please tell me what type of sentence that is : " << std::endl;
	std::cout << "1. Declarative" << std::endl;
	std::cout << "2. Imperative" << std::endl;
	std::cout << "3. Exclamatory" << std::endl;
	std::cout << "4. Interrogative" << std::endl;
	std::cout << "5. Overlook Mistake" << std::endl;
	std::cout << "Type : ";
	std::cin >> choice;

	switch (choice - 1)
	{
	case 0: return types[0];
	case 1: return types[1];
	case 2: return types[2];
	case 3: return types[3];
	case 4: return "";
	}
}

bool Structure::Review(std::string sentence)
{
	if (sentence.substr(0, 2) != "-/")
		return false;

	sentence.erase(0, 2);

	if (sentence == "build:enable") debug_mode = sentence;
	if (sentence == "build:disable") debug_mode = sentence;
	if (sentence == "record:enable") debug_mode = sentence;
	if (sentence == "record:disable") debug_mode = sentence;

	std::cout << std::endl << "DEBUG : " << debug_mode << std::endl << std::endl;
	return true;
}

std::string Structure::Construct(std::string sentence)
{
	Bank* bank = Deconstruct(sentence);
	std::string type = Decrypt(sentence);
	std::string word;

	if (type == "") return "I will record these failures to make sense.";

	/*
		Building a proper response :
			- 
	*/

	Record(type, bank);

	return ResponseDatabase(sentence);

	return word;
}

std::string Structure::ResponseDatabase(std::string sentence)
{
	Node* node = phrase.archive->bank->head;
	int count = 0;

	while (node != nullptr)
	{
		if (node->data == sentence)
			return response.archive->bank->ElementAt(count);

		node = node->next;
		count += 1;
	}

	phrase.archive->bank->Insert(sentence, "");
	std::cout << std::endl << "I am unsure on how to respond." << std::endl << "What is a good response?" << std::endl;
	getline(std::cin, sentence);
	response.archive->bank->Insert(sentence, "");

	if (sentence == "-/abort")
	{
		phrase.archive->bank->Remove(phrase.archive->bank->ElementAt(phrase.archive->bank->length));
		response.archive->bank->Remove(sentence);
		return "Oh, You got my hopes up...";
	}

	phrase.archive->Save(true);
	response.archive->Save(true);

	return "Pair recorded.";
}

void Structure::Record(std::string type, Bank* bank)
{
	if (type.find(types[0]) != std::string::npos) declarative.archive->Modify("+i", bank);
	if (type.find(types[1]) != std::string::npos) imperative.archive->Modify("+i", bank);
	if (type.find(types[2]) != std::string::npos) exclamatory.archive->Modify("+i", bank);
	if (type.find(types[3]) != std::string::npos) interrogative.archive->Modify("+i", bank);
}

Bank* Structure::Deconstruct(std::string sentence)
{
	Bank* bank = new Bank();
	std::string word = "";

	for (int i = 0; i < sentence.length(); i++)
	{
		char letter = sentence[i];
		if (!isalpha(letter) && letter != '\'')//&& letter != '.' && letter != '-')
		{
			transform(word.begin(), word.end(), word.begin(), (int(*)(int))tolower);

			/*
				- Check if contains "'"
				- Check if contraction contains
				- Subtract length of word
				- Add contaction breakdown to sentence
				- continue
			*/

			if (word.find("'") != std::string::npos)
			{
				int len = sentence.length();
				int index = contraction.archive->bank->Find(word);
				i -= word.length();
				//std::cout << index << std::endl;

				sentence.replace(i, word.length(), contraction.archive->bank->ElementTypeAt(index));
				
				// Replace sentence
				std::cout << sentence << std::endl;
				// Continue

				word = "";
				i--;
				continue;
			}

			bank->Insert(word, GetSignature(word));
			word = "";
		}
		else word += letter;
	}
	return bank;
}

std::string Structure::GetSignature(std::string data)
{
	std::string data_copy = data;
	int test = 0;

shallow_check: // Shallow test
	if (preposition.archive->bank->Find(data) != -1) return preposition.archive->identity;
	if (verb.archive->bank->Find(data) != -1) return verb.archive->identity;
	if (noun.archive->bank->Find(data) != -1) return noun.archive->identity;
	if (pronoun.archive->bank->Find(data) != -1) return pronoun.archive->identity;
	if (adjective.archive->bank->Find(data) != -1) return adjective.archive->identity;
	if (adverb.archive->bank->Find(data) != -1) return adverb.archive->identity;
	if (article.archive->bank->Find(data) != -1) return article.archive->identity;
	if (conjunction.archive->bank->Find(data) != -1) return conjunction.archive->identity;
	if (interjection.archive->bank->Find(data) != -1) return interjection.archive->identity;

	// Deep test
	/*
		- Remove suffix
		- Remove prefix
		- Remove suffix and add 'e'
		- Remove suffix and prefix
	*/
deep_check:
	data = data_copy;
	switch (test)
	{
	case 0:
		suffix.archive->bank->Trim(&data, 0);
		test += 1;
		break;
	case 1:
		prefix.archive->bank->Trim(&data, 1);
		test += 1;
		break;
	case 2:
		suffix.archive->bank->Trim(&data, 0);
		data += 'e';
		test += 1;
		break;
	case 3:
		suffix.archive->bank->Trim(&data, 0);
		prefix.archive->bank->Trim(&data, 1);
		test += 1;
		break;
	case 4:
		data = "";
		break;
	}
		
	if (data == data_copy) goto deep_check;
	if (test < 4) goto shallow_check;

	std::string group;
	std::cout << "I am sorry. It seems I have not heard of \"" << data_copy << "\"." << std::endl;
	std::cout << "What grammarical group is it from (please use '_' instead of ' ') : ";
	getline(std::cin, group);

	if (verb.archive->identity == group) { verb.archive->bank->Insert(data_copy, ""); verb.archive->Save(true); return group; }
	if (noun.archive->identity == group) { noun.archive->bank->Insert(data_copy, ""); noun.archive->Save(true); return group; }
	if (preposition.archive->identity == group) { preposition.archive->bank->Insert(data_copy, ""); preposition.archive->Save(true); return group; }
	if (pronoun.archive->identity == group) { pronoun.archive->bank->Insert(data_copy, ""); pronoun.archive->Save(true); return group; }
	if (adjective.archive->identity == group) { adjective.archive->bank->Insert(data_copy, ""); adjective.archive->Save(true); return group; }
	if (adverb.archive->identity == group) { adverb.archive->bank->Insert(data_copy, ""); adverb.archive->Save(true); return group; }
	if (article.archive->identity == group) { article.archive->bank->Insert(data_copy, ""); article.archive->Save(true); return group; }
	if (conjunction.archive->identity == group) { conjunction.archive->bank->Insert(data_copy, ""); conjunction.archive->Save(true); return group; }
	if (interjection.archive->identity == group) { interjection.archive->bank->Insert(data_copy, ""); interjection.archive->Save(true); return group; }

	return "unsigned";
}