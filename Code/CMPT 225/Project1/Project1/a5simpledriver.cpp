// File:        a5simpledriver.cpp
// Author:      Geoffrey Tien
// Date:        March 26, 2016
// Description: Simple test driver and UI for CMPT 225 assignment 5

#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>

#include "slinkedlist.h"
#include "hashtable.h"

using namespace std;

// forward function declarations
void PrintMenu(bool loginstatus, int ulevel);
void LLTest();
void HTTest();

// program entry point

int main()
{
  cout << "Entering linked list test..." << endl;
  LLTest();
  cout << "Entering hash table test..." << endl;
  HTTest();
  cout << endl;

  int choice = 0;
  string inputchoice;
  string inputname = "";    // currently logged in user
  string inputnewname = ""; // for adding or removing user
  string inputoldpassword1 = "";
  string inputoldpassword2 = "";
  string inputnewpassword = "";
  bool passwordmismatch = true;
  string inputlevel = "";
  int ilevel = 1;

  bool loggedin = false;
  int level = REGULAR_;

  HashTable ht;
  // insert a default admin account
  ht.Insert(UserAccount("admin", ADMIN_));

  while (choice != 7)
  {
    PrintMenu(loggedin, level);
    // get the menu choice from standard input
    getline(cin, inputchoice);
    choice = atoi(inputchoice.c_str());

    switch (choice)
    {
      case 1:
        // log in, log out
        if (!loggedin)
        {
          cout << "Enter username: ";
          getline(cin, inputname);
          cout << "Enter password: ";
          getline(cin, inputoldpassword1);
          if (!ht.Search(UserAccount(inputname, 0)))
          {
            cout << "Invalid username.\n" << endl;
          }
          else
          {
            UserAccount* ua = ht.Retrieve(UserAccount(inputname, 0)); // will not return NULL
            if (inputoldpassword1 != ua->GetPassword())
            {
              cout << "Invalid password.\n" << endl;
            }
            else
            {
              loggedin = true;
              level = ua->GetUserLevel();
            }
          }
        }
        else
        {
          cout << "Logged out.\n" << endl;
          loggedin = false;
          level = REGULAR_;
          // clear local variables for next login
          inputname = "";
          inputnewname = "";
          inputoldpassword1 = "";
          inputoldpassword2 = "";
          inputnewpassword = "";
          passwordmismatch = true;
        }
        break;
      case 2:
        // change password
        if (loggedin)
        {
          passwordmismatch = true;
          while (passwordmismatch && inputoldpassword1 != "quit")
          {
            cout << "Enter old password or type quit to exit: ";
            getline(cin, inputoldpassword1);
            if (inputoldpassword1 != "quit")
            {
              cout << "Enter old password again: ";
              getline(cin, inputoldpassword2);
              passwordmismatch = (inputoldpassword1 != inputoldpassword2);
            }
            else
            {
              passwordmismatch = false;
            }
          }
          if (inputoldpassword1 != "quit")
          {
            cout << "Enter new password: ";
            getline(cin, inputnewpassword);
            if (ht.Retrieve(UserAccount(inputname, 0))->SetPassword(inputoldpassword1, inputnewpassword))
              cout << "Password updated.\n" << endl;
            else
              cout << "Error updating password.\n" << endl;
          }
        }
        break;
      case 3:
        // admin-only, add new user
        if (loggedin && level == ADMIN_)
        {
          cout << "Enter new username (lowercase only): ";
          getline(cin, inputnewname);
          cout << "Enter access level (0 = ADMIN, 1 = REGULAR): ";
          getline(cin, inputlevel);
          ilevel = atoi(inputlevel.c_str());
          if (ht.Insert(UserAccount(inputnewname, ilevel)))
            cout << "New user " << inputnewname << " added.\n" << endl;
          else
            cout << "Error adding user.\n" << endl;
        }
        break;
      case 4:
        // admin-only, reset user password
        if (loggedin && level == ADMIN_)
        {
          cout << "Enter username for password reset: ";
          getline(cin, inputnewname);
          if (!ht.Search(UserAccount(inputnewname, 0)))
          {
            cout << "Invalid username.\n" << endl;
          }
          else
          {
            UserAccount* uap = ht.Retrieve(UserAccount(inputnewname, 0));
            uap->SetPassword(uap->GetPassword(), "password");
            cout << "Password for user " << uap->GetUsername() << " reset to default.\n" << endl;
          }
        }
        break;
      case 5:
        // admin-only, edit user level
        if (loggedin && level == ADMIN_)
        {
          cout << "Enter username for access level edit: ";
          getline(cin, inputnewname);
          if (inputnewname == "admin")
          {
            cout << "Cannot edit access level of admin.\n" << endl;
          }
          else if (!ht.Search(UserAccount(inputnewname, 0)))
          {
            cout << "Invalid username.\n" << endl;
          }
          else
          {
            cout << "Enter new access level (0 = ADMIN, 1 = REGULAR): ";
            getline(cin, inputlevel);
            ilevel = atoi(inputlevel.c_str());
            UserAccount* uap = ht.Retrieve(UserAccount(inputnewname, 0));
            if (uap->SetUserLevel(ilevel))
              cout << "Access level for user " << uap->GetUsername() << " successfully changed.\n" << endl;
            else
              cout << "Error setting access level for user " << uap->GetUsername() << ".\n" << endl;
          }
        }
        break;
      case 6:
        // admin-only, remove user
        if (loggedin && level == ADMIN_)
        {
          cout << "Enter username to remove: ";
          getline(cin, inputnewname);
          if (inputnewname == "admin")
          {
            cout << "Cannot remove admin.\n" << endl;
          }
          else if (ht.Remove(UserAccount(inputnewname, 0)))
          {
            cout << "User " << inputnewname << " removed.\n" << endl;
          }
          else
          {
            cout << "Error removing user " << inputnewname << ".\n" << endl;
          }
        }
        break;
      case 7:
        // do nothing, causes while loop to exit
        break;
      default:
        break;
    }
  }

  return 0;
}

void PrintMenu(bool loginstatus, int ulevel)
{
  if (!loginstatus)
  {
    cout << "****************************************************\n"
         << "* Please select an option:                         *\n"
         << "* 1. Login                     7. Quit             *\n"
         << "****************************************************\n" << endl;
    cout << "Enter your choice: ";
  }
  else
  {
    if (ulevel == ADMIN_)
    {
      cout << "****************************************************\n"
           << "* Please select an option:                         *\n"
           << "* 1. Logout                    6. Remove a user    *\n"
           << "* 2. Change password                               *\n"
           << "* 3. Add a new user                                *\n"
           << "* 4. Reset user password                           *\n"
           << "* 5. Edit user level           7. Quit             *\n"
           << "****************************************************\n" << endl;
      cout << "Enter your choice: ";
    }
    else
    {
      cout << "****************************************************\n"
           << "* Please select an option:                         *\n"
           << "* 1. Logout                    7. Quit             *\n"
           << "* 2. Change password                               *\n"
           << "****************************************************\n" << endl;
      cout << "Enter your choice: ";
    }
  }
}

void LLTest()
{
  SLinkedList<int> lla;
  lla.Contains(5);
  vector<int> v1 = lla.Dump();
  lla.InsertBack(2);
  lla.InsertFront(1);
  lla.IsEmpty();
  lla.Remove(3);
  lla.Retrieve(1);
  lla.Size();
  SLinkedList<int> llb(lla);
  SLinkedList<int> llc = lla;
}

void HTTest()
{
  HashTable ht1;
  HashTable ht2(10);
  ht1.Size();
  ht1.MaxSize();
  ht1.ListAt(0);
  ht1.LoadFactor();
  ht1.Insert(UserAccount("admin", ADMIN_));
  ht1.Remove(UserAccount("bob", REGULAR_));
  ht1.Retrieve(UserAccount("bob", REGULAR_));
  ht1.Search(UserAccount("bob", ADMIN_));
  HashTable ht3 = ht1;
}