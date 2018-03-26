// File:        useraccount.h
// Author:      Geoffrey Tien
// Date:        March 25, 2016
// Description: Definition of a user account class for CMPT 225 assignment 5

#pragma once

// user account types
#define ADMIN_   0
#define REGULAR_ 1

#include <string>

using namespace std;

class UserAccount
{
  private:
    string username;
    string password;
    int userlevel;   // ADMIN_ or REGULAR_

  public:
    // default constructor
    UserAccount();

    // semi-parameterized constructor
    UserAccount(string name, int level);

    // MUTATORS
    // update username
    void SetUsername(string name);

    // update password attribute to new password and return true if oldpassword matches existing password
    // return false otherwise
    bool SetPassword(string oldpassword, string newpassword);

    // update userlevel and return true if parameter is different from current userlevel
    // return false otherwise
    bool SetUserLevel(int level);

    // ACCESSORS
    string GetUsername() const;

    string GetPassword() const;

    int GetUserLevel() const;

    // OVERLOADED OPERATORS
    bool operator==(const UserAccount& acct) const;
    bool operator!=(const UserAccount& acct) const;
};