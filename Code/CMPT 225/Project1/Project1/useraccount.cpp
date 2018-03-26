// File:        useraccount.cpp
// Author:      Geoffrey Tien
// Date:        March 25, 2016
// Description: Definition of a user account class for CMPT 225 assignment 5

#include "useraccount.h"

// default constructor
UserAccount::UserAccount()
{
  username = "user";
  password = "password"; // default password
  userlevel = REGULAR_;
}

// semi-parameterized constructor
UserAccount::UserAccount(string name, int level)
{
  username = name;
  password = "password"; // default password
  if (level == ADMIN_ || level == REGULAR_)
    userlevel = level;
  else
    userlevel = REGULAR_;
}

// MUTATORS

// update username
void UserAccount::SetUsername(string name)
{
  username = name;
}

// update password attribute to new password and return true if oldpassword matches existing password
// return false otherwise
bool UserAccount::SetPassword(string oldpassword, string newpassword)
{
  if (newpassword != "" && oldpassword == password)
  {
    password = newpassword;
    return true;
  }
  return false;
}

// update userlevel and return true if parameter is different from current userlevel
// return false otherwise
bool UserAccount::SetUserLevel(int level)
{
  if (level != userlevel && (level == ADMIN_ || level == REGULAR_))
  {
    userlevel = level;
    return true;
  }
  return false;
}

// ACCESSORS
string UserAccount::GetUsername() const
{
  return username;
}

string UserAccount::GetPassword() const
{
  return password;
}

int UserAccount::GetUserLevel() const
{
  return userlevel;
}

// OVERLOADED OPERATORS
bool UserAccount::operator==(const UserAccount& acct) const
{
  return (username == acct.username);
}

bool UserAccount::operator!=(const UserAccount& acct) const
{
  return !(*this == acct);
}