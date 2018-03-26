// File:        stockitem.cpp
// Author:      Geoffrey Tien
// Date:        2016-02-27
// Description: Implementation of a StockItem class for use with CMPT 225 assignment #4

#include "stockitem.h"

// Default constructor
StockItem::StockItem()
{
  sku = 0;
  description = "";
  price = 0;
  stock = 0;
}

// Parameterized constructor
// Need to specify SKU, description, and price.
// Stock is defaulted to 0;
// Assume parameters are valid
StockItem::StockItem(int skuid, string desc, double p)
{
  sku = skuid;
  if (sku > 99999) sku = sku % 100000;
  if (sku < 10000) sku += 10000;       // force sku to 5 digits
  
  if (desc.length() > 30)
    description = desc.substr(0, 29);
  else
    description = desc;
  price = p;
  stock = 0;
}

// Accessors
int StockItem::GetSKU() const
{
  return sku;
}

string StockItem::GetDescription() const
{
  return description;
}

double StockItem::GetPrice() const
{
  return price;
}

int StockItem::GetStock() const
{
  return stock;
}

// Mutators
// boolean return values - return true for successful update, false if argument is invalid (i.e. negative price/stock/SKU)
bool StockItem::SetDescription(string newdesc)
{
  if (newdesc.length() > 30)
    description = newdesc.substr(0, 29);
  else
    description = newdesc;
  return true;
}

bool StockItem::SetPrice(double newprice)
{
  if (newprice >= 0)
  {
    price = newprice;
    return true;
  }
  else return false;
}

bool StockItem::SetStock(int amount)
{
  if (amount >= 0)
  {
    stock = amount;
    return true;
  }
  else return false;
}

bool StockItem::operator==(const StockItem& item) const
{
  return (sku == item.GetSKU());
}

bool StockItem::operator!=(const StockItem& item) const
{
  return !(*this == item);
}

bool StockItem::operator>(const StockItem& item) const
{
  return (sku > item.GetSKU());
}

bool StockItem::operator<(const StockItem& item) const
{
  return (sku < item.GetSKU());
}

bool StockItem::operator>=(const StockItem& item) const
{
  return !(*this < item);
}

bool StockItem::operator<=(const StockItem& item) const
{
  return !(*this > item);
}

StockItem& StockItem::operator=(const StockItem& item)
{
  if (this != &item)
  {
    this->sku = item.sku;
    this->description = item.description;
    this->price = item.price;
    this->stock = item.stock;
  }
  return *this;
}