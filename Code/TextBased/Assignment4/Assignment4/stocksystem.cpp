#include "stocksystem.h"
#include "redblacktree.h"

#include <iostream>    
#include <algorithm>

// default constructor;
// begin with a balance of $100,000.00
StockSystem::StockSystem()
{
	balance = 100000;
}

// returns the balance member
double StockSystem::GetBalance()
{
	return balance;
}

// Add a new SKU to the system. Do not allow insertion of duplicate sku
bool StockSystem::StockNewItem(StockItem item)
{
	return records.Insert(item);
}

// Locate the item with key itemsku and update its description field.
// Return false if itemsku is not found.
bool StockSystem::EditStockItemDescription(int itemsku, string desc)
{
	StockItem node;

	int cataloguesize = 0;
	StockItem* catalogue = records.Dump(cataloguesize);
	for (int i = 0; i < cataloguesize; i++)
	{
		if (catalogue[i].GetSKU() == itemsku)
		{
			node = catalogue[i];
		}
	}

	StockItem* item = nullptr;
		if (records.Search(node))
		{
			item = records.Retrieve(node);
			item->SetDescription(desc);
		}

	return item != nullptr;
}

// Locate the item with key itemsku and update its description field.
// Return false if itemsku is not found or retailprice is negative.
bool StockSystem::EditStockItemPrice(int itemsku, double retailprice)
{
	StockItem node;

	int cataloguesize = 0;
	StockItem* catalogue = records.Dump(cataloguesize);
	for (int i = 0; i < cataloguesize; i++)
	{
		if (catalogue[i].GetSKU() == itemsku)
		{
			node = catalogue[i];
		}
	}

	StockItem* item = nullptr;
	if (records.Search(node))
	{
		item = records.Retrieve(node);
		item->SetPrice(retailprice);
	}

	return item != nullptr;
}

// Purchase quantity of item at unitprice each, to reach a maximum (post-purchase) on-hand stock quantity of 1000.
// Return false if balance is not sufficient to make the purchase,
//   or if SKU does not exist, or if quantity or unitprice are negative.
// Otherwise, return true and increase the item's on-hand stock by quantity,
//   and reduce balance by quantity*unitprice.
bool StockSystem::Restock(int itemsku, int quantity, double unitprice)
{

	StockItem node;

	int cataloguesize = 0;
	StockItem* catalogue = records.Dump(cataloguesize);
	for (int i = 0; i < cataloguesize; i++)
	{
		if (catalogue[i].GetSKU() == itemsku)
		{
			node = catalogue[i];
		}
	}

	StockItem* item = nullptr;
	if (records.Search(node))
	{
		item = records.Retrieve(node);
		item->SetStock(item->GetStock() + quantity);
		balance -= quantity * unitprice;
	}

	return item != nullptr;
}

// Sell an item to a customer, if quantity of stock is available and SKU exists.
// Reduce stock by quantity, increase balance by quantity*price, and return true if stock available.
// If partial stock (less than quantity) available, sell the available stock and return true.
// If no stock, sku does not exist, or quantity is negative, return false.
bool StockSystem::Sell(int itemsku, int quantity)
{
	StockItem node;

	int cataloguesize = 0;
	StockItem* catalogue = records.Dump(cataloguesize);
	for (int i = 0; i < cataloguesize; i++)
	{
		if (catalogue[i].GetSKU() == itemsku)
		{
			node = catalogue[i];
		}
	}

	StockItem* item = nullptr;
	if (records.Search(node))
	{
		item = records.Retrieve(node);
		item->SetStock(item->GetStock() - quantity);
		balance += quantity * item->GetPrice();
	}

	return item != nullptr;
}