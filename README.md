# Sales-Engine

## What is Sales Engine?
  
  * A project to practice building a system of several interacting Ruby objects using Test Driven Development. The program is a data reporting tool that manipulates and reports on merchant transactional data.
-------------------------------------------------------------------------------------
## What I Will Learn From Doing This Project

  * How to use tests to drive both design and implementation of the code
  * Project Management and how to track and meet daily goals in order to meet the deadline
  * Be able to implement test fixtures instead of actual data when testing
  * Build a complex system of relationships using multiple interacting classes
  * Demonstrate through the design the DRY principle with the usage of modules and/or duck typing
  * Learn and properly separate parsing and data loading logic from the business logic
  * Use memoization to improve performance
  * How to implement a rake task to run all of the tests as well as be able to independently run each test file
  * How to incorporate a Spec Harness while also being able to rely on the test that are created outside of that
-------------------------------------------------------------------------------------
## CHALLENGES

  * Building several classes to implement an API that allows for querying of data including objects and methods that are listed in the rubric
  * Making sure to build a system that can parse data files and create relationships between the various objects and not creating object dependencies between classes
-------------------------------------------------------------------------------------
## WHAT TO BUILD UPON

  * The Sales Engine MUST live in a file named lib/sales_engine and require statements for the other classes in the project and must be require_relative
  * After calling upon the following code:

  engine = SalesEngine.new
  engine.startup

  all of the following dependencies should be loaded up:

  require 'csv'
  require_relative 'merchant'
  require_relative 'merchant_repository'
  etc.

  class SalesEngine
    # code goes here
  end
-------------------------------------------------------------------------------------
  * Provided are six CSV files. Each one represents a data structure that is a part of the Sales Engine.
    * Merchant Repository => holds objects of the Merchant
    * Invoice Repository => holds objects of the Invoice
    * Item Repository => holds the objects of the Item
    * Customer Repository => holds the objects of the Customer
    * Transaction Repository => holds the objects of the Transaction
-------------------------------------------------------------------------------------
  *** SALES ENGINE WILL HAVE A REFERENCE TO EACH REPOSITORY ***
  **** THEY WILL BE ACCESSED LIKE SO: 

  engine = SalesEngine.new
  engine.startup

  engine.merchant_repository
  engine.invoice_repository
  engine.item_repository
  engine.invoice_item_repository
  engine.customer_repository
  engine.transaction_repository

  ** EACH REPOSITORY IS REQUIRED TO DO THE FOLLOWING: 

    * "ALL" => returns all instances
    * "RANDOM" => returns a random instance
    * FIND_BY_X(MATCH) => X is an attribute where it returns a single instance whose X attribute case insensitive attribute matches the MATCH parameter
        *EXAMPLE: customer_repository.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen"

    * FIND_ALL_BY_X(MATCH) works just like find_by_X EXCEPT it RETURNS A COLLECTION OF ALL MATCHES. NO MATCH => EMPTY ARRAY
-------------------------------------------------------------------------------------
    ***** LET'S TALK ABOUT RELATIONSHIPS *****

    MERCHANT: 

    * When calling upon items, it will return a collection of objects of the Item associated with a specific merchant for the products that are specifically being sold by that merchant

    * When calling upon invoices, it will return a collection of objects of the Invoice associated with that specific merchant from orders only associated with that specific merchant

    INVOICE:

    * When calling upon transactions, it will return a collection of objects associated with the Transaction

    * When calling upon invoice_items, it will return a collection of objects associated with the InvoiceItem

    * When calling upon items, it will return a collection of associated Items through objects of the InvoiceItem

    * When calling upon customer, it will return an object of the Customer that is associated with that object

    * When calling upon merchant, it will return an object of the Merchant that is associated with that object

    INVOICE ITEM:

    * When calling upon invoice, it will return an object of the Invoice associated with this object

    * When calling upon item, it will return an object of the Item associated with this object

    ITEM: 

    * When calling upon invoice_items, it will return a collection of InvoiceItems associated with this object

    * When calling upon merchant, it will return an object of the Merchant associated with this object

     TRANSACTION: 

     * When calling upon invoice, it will return an object of the Invoice associated with this object

     CUSTOMER:

     * When calling upon invoices, it will return a collection of Invoice instances associated with this object
-------------------------------------------------------------------------------------
     *********** DIFFICULTY LEVEL: HIGH - BUSINESS INTELLIGENCE **************

     MERCHANT REPOSITORY:

     * MOST_REVENUE(X) => returns the top X merchants ranked by total revenue
     * MOST_ITEMS(X) => returns the top X merchants ranked by total number of items sold
     * REVENUE(DATE) => returns the total revenue for that date across all merchants

     MERCHANT

     * REVENUE => returns the total revenue for that merchant across all transactions
     * REVENUE(DATE) => returns the total revenue for that merchant for a specific invoice date
     * FAVORITE_CUSTOMER => returns the Customer who has conducted the most successful transactions
     * CUSTOMERS_WITH_PENDING_INVOICES(PAY YOUR INVOICE!) => returns a collection of objects of the Customer which have pending(unpaid) invoices. IF NONE OF THE TRANSACTIONS ARE SUCCESSFUL == PENDING INVOICE

     ** NOTE ** Failed charges are not counted in revenue totals or statistics and all revenues should be reported as BIGDECIMAL object with TWO DECIMAL PLACES

     ITEM REPOSITORY

     * MOST_REVENUE(X) => returns the top X items ranked by total revenue generated
     * MOST_ITEMS(X) => returns the top X items ranked by total number sold 

     ITEM

     * BEST_DAY => returns the date with the most sales for the given item using the invoice date

     CUSTOMER

     * TRANSACTIONS => returns an ARRAY of objects of the Transaction associated with a customer
     * FAVORITE_MERCHANT => returns an object of Merchant where the customer has conducted the most successful transactions 
-------------------------------------------------------------------------------------

## CREATING INVOICES AND RELATED OBJECTS

* Given a HASH OF INPUTS, using this syntax will allow you to create new invoices quickly

invoice = invoice_repository.create(customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3])

* ASSUME THAT CUSTOMER, MERCHANT, AND ITEM1, ITEM2, and ITEM3 are objects of their RESPECTIVE CLASSES

* you SHOULD determine the QUANTITY BOUGHT for each ITEM by how many times the item is in the :items array. 

EXAMPLE: 
                                 ITEM   QUANTITY BOUGHT
                                ------ ----------------
ITEMS: [Item1, Item1, Item2]    Item1 :      2
                                Item2 :      1

ON INVOICE, YOU CAN CALL:

invoice.charge(credit_card_number: "4444333322221111",
               credit_card_expiration: "10/13", result: "success")                                








