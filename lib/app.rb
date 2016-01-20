require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price
brands_data = {}
products_hash["items"].each do |toy|

	#this code aggregates data on brands level
	#used later in this code
	if brands_data.key?(toy["brand"])
		brands_data[toy["brand"]]["no_of_products"] += 1
		brands_data[toy["brand"]]["prices"].push toy["full-price"]
	else
		brands_data[toy["brand"]] = {"no_of_products"=>1,"prices"=>[toy["full-price"]],"purchases"=>[]}
	end

	puts toy["title"]
	puts "*"*30
	price = toy["full-price"].to_f
	puts "Retail Price: $#{price}"
	purchases = toy["purchases"].length #calculate no of purchases
	puts "Total Purchaeses: #{purchases}"

	#calculate total sales amount
	sales_amount = 0.0
	toy["purchases"].each do |purchase|
		sales_amount += purchase["price"]
		brands_data[toy["brand"]]["purchases"].push purchase["price"]
	end

	puts "Total Sales: $#{sales_amount}"
	average_price = sales_amount / purchases
	puts "Average Price: $#{average_price}"
	average_discount = ((price-average_price)/price*100).round(2) #round the value to two digits of decimal
	puts "Average Discount: #{average_discount}%"
	puts "*"*30
	puts "\n\n"
end


	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined
brands_data.each do |key,value|
	puts key
	puts "*"*30
	puts "Number of Products: #{value["no_of_products"]}"
	total_prices = 0.0
	value["prices"].each do |price|
		total_prices += price.to_f
	end
	average_price = (total_prices/value["no_of_products"]).round(2)
	puts "Average Price: $#{average_price}"
	total_sales = 0.0
	value["purchases"].each { |price| total_sales += price }
	puts "Total Sales: $#{total_sales.round(2)}"
	puts "*"*30
	puts "\n\n"
end
