#ifndef _STRING_H
#define _STRING_H

// C Runtime Header Files
#ifndef _TCMAR_INC_
	#include <tchar.h>
#endif // !_TCMAR_INC_
#ifndef _STRING_
	#include <string>
#endif // !_STRING_

// Defines
#ifdef UNICODE
	#define tstring wstring
	#define TOSTRING(value) std::to_wstring(value)
#else
	#define tstring string
	#define TOSTRING(value) std::to_string(value)
#endif // UNICODE
#endif // !_STRING_H
