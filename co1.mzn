include "globals.mzn"; 
%How many parts we want to buy
int: products_required;
%How many stores we ahve nearby
int: nearby_stores;


%The price of the particular product in a particular store
array[1..products_required, 1..nearby_stores] of float: particular_product_cost;
%Delivery Cost of a product from a particular store
array[1..nearby_stores] of float: store_delivery_costs;

% decision variables
array[1..products_required] of var 1..nearby_stores: x; % which store to by product p?
var 0.0..max(array1d(particular_product_cost)): product_cost; %Cost of each of the product
var 0.0..max(store_delivery_costs): delivery_cost; %Delivery cost from each shop
var float: total_cost = product_cost + delivery_cost;

solve minimize total_cost; %We want to minimize total product cost and delivery cost


constraint

  total_cost >= 0.0 /\   % total cost must be atleast 1 because if 0, that means product is not available in the store

 
  forall(p in 1..products_required) (
   
     particular_product_cost[p,x[p]] > 0.01   % a selected part must be in an available store
  )
  /\

  % total cost for the selected products 
  product_cost= sum([particular_product_cost[p,x[p]] | p in 1..products_required])
  /\

  % the delivery cost
  delivery_cost = sum([
                    % is there something bought from shop s?
                    if sum([x[p] = s | p in 1..products_required]) > 0 then 
                        store_delivery_costs[s]  % if product bought from that shop , that particular delivery cost is added
                    else 
                        0 % if nothing bought from that shop, no delivery cost added
                    endif                 
                | s in 1..nearby_stores])
;

output 
[
 "SHOP ID: \(x)\n",
 "Part Cost: \(product_cost)\n",
 "Delivery Cost: \(delivery_cost)\n",
 "Total Cost: \(total_cost)\n",
];

