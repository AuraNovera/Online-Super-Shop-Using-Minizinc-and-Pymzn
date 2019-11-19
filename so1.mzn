include "globals.mzn"; 
%How many parts we want to buy
int: products_required;
%How many stores we have nearby
int: nearby_stores;

%The size of the particular product in a particular store
array[1..products_required, 1..nearby_stores] of float:particular_product_size;

%delivery cost of a product from that shop
array[1..products_required,1..nearby_stores] of float: store_delivery_costs;

%Cost of the product bought from a particular shop
array[1..products_required,1..nearby_stores] of float: store_product_costs;


% decision variables
array[1..products_required] of var 1..nearby_stores: x;  % from which store we have bought a product


var 0.0..max(array1d(particular_product_size)): part_size; % The sizes of the products


var 0.0..max(store_delivery_costs): delivery_cost;
var 0.0..max(store_product_costs): product_cost;


var float: total_cost = delivery_cost;
var float: total_size = part_size ;
var float: p_cost = product_cost ;

solve minimize total_size; % We want to have the products having the minimum size.


constraint

  total_size >= 0.0 /\


  forall(p in 1..products_required) (
    
    particular_product_size[p,x[p]] > 0.01    % a selected product must be available in the store
  )
  /\

  % total cost for the parts
  part_size= sum([particular_product_size[p,x[p]] | p in 1..products_required])
  /\
  
      product_cost = sum([
                    % is there something bought from shop s?
                    if sum([particular_product_size[p,x[p]]| p in 1..products_required]) > 0 then 
                        store_product_costs[p,x[p]]  %if that particular product is chosen, add the product cost
                    else 
                        0    %if that particular product is chosen,donot add the product cost
                     endif                 
               | p in 1..products_required])
                        
                        

                
         /\

  % the delivery cost
   delivery_cost = sum([
                    % is there something bought from shop s?
                    if sum([particular_product_size[p,x[p]]| p in 1..products_required]) > 0 then 
                        store_delivery_costs[p,x[p]]  % If something bought from that shop, add the delivery cost
                    else 
                        0  % if sth not bought form the shop donot add the delivery cost
                     endif                 
               | p in 1..products_required])
                ;


output 
[
 "SHOP ID: \(x)\n",
 "Total Cost of the Products: \(product_cost)\n",
 "Delivery Cost: \(delivery_cost)\n",
 "Total Optimized Area: \(total_size)\n",
];

