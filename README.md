# 
Task description:

Consider a grocery market where items have prices per unit but also volume prices. For example, doughnuts may be $1.00 each or 3 for $2.75 dollars. 
Implement a point-of-sale scanning API that accepts an arbitrary ordering of products (similar to what would happen when actually at a checkout line) 
then returns the correct total price for an entire shopping cart based on the per unit prices or the volume prices as applicable.
Implement discount card functionality, which decrise total amount of the purchase on different percent (percent depends on total total amount of the purchase).

Here are the products listed by code and the prices to use (there is no sales tax): 
Product Code Price


A $1.00 each or 3 for $2.75 


B $3.50 


C $1.50 or $5 for a four pack 


D $0.75


F - discount card (F -5%, FF -7%, FFF -10%)


The interface at the top level PointOfSaleTerminal service object should look something like this. You are free to design/implement the rest of the code however you wish, including how you specify the prices in the system: 


terminal = PointOfSaleTerminal.new; terminal.setPricing(...); 
terminal.scan("A");
terminal.scan("C");
 ... etc. 

result = terminal.calculateTotal(); 
    
Your project also should contain some way of running automated tests to prove it works. 
Here are the minimal inputs you should use for your test cases. 
These test cases must be shown to work in your program: 


    Scan these items in this order: ABCDABA; 
    Verify the total price is $12.00. 
    
    Scan these items in this order: AAAAAAAA; 
    Verify the total price is $7.50 
    
    Scan these items in this order: ABFFCD; 
    Verify the total price is $6.28
