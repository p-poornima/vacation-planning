require "selenium-webdriver"

driver = Selenium::WebDriver.for :firefox, marionette: true

driver.get "http://phptravels.net/admin"
driver.manage.window.maximize

AdminEmailButton=driver.find_element(:name, "email")
AdminEmailButton.send_keys "admin@phptravels.com"

AdminPasswordButton=driver.find_element(:name, "password")
AdminPasswordButton.send_keys "demoadmin"

#clicking on Login button
LoginButton = driver.find_element(:css, 'button[type="submit"]')
LoginButton.click

#Clicking on Tours
sleep 5
driver.find_element(:link_text, "Tours").click

#Clicking on Add new tour
sleep 4
addnew=driver.find_element(:css, "a[href='http://phptravels.net/admin/tours/add/']")
addnew.click

#Asserting whether on the Add Tour Page
#pagetitle=driver.title
currentURL=driver.current_url
"http://phptravels.net/admin/tours/add/".eql?currentURL
puts "On Add New Tour page"

#wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds

#to generate unique tour name every time
timestamp=Time.now.to_i.to_s

sleep 5

#Tour name
tourname=driver.find_element(:name, "tourname")
tour_name="MyTour_"+timestamp
tourname.send_keys tour_name
puts "Tour name is " + tour_name

sleep 6
#Tour description
########???
tour_description=driver.find_element(:css, "iframe.cke_wysiwyg_frame")
tour_description.click
tour_description.send_keys "My first tour."

#Quantity
quantity=driver.find_element(:name, "maxadult")
quantity.send_keys("2")
puts "Number of adult is 2"

#Price
price=driver.find_element(:name, "adultprice")
price.send_keys "$800"
puts "Adult price is $800"


adult_enable_button=driver.find_element(:id, "adultbtn")
adult_enable_button.click
puts "Adult enable button enabled"

#stars
stars=driver.find_element(:name, "tourstars")
options = stars.find_elements(:tag_name, 'option')
options.each { |option| option.click if option.text == '4'}
puts "Stars 4 chosen"

#total days
total_days=driver.find_element(:name, "tourdays")
total_days.send_keys "5"
puts "Total days are 5"

#total nights
total_nights=driver.find_element(:name, "tournights")
total_nights.send_keys "4"
puts "Total nights are 4"

#tour type
driver.find_element(:css, "div.select2-container").click
driver.find_element(:xpath, "//*[text()='Private']").click
puts "Private is selected as tour type."

#dates
driver.find_element(:css, "input[placeholder='From']").click

sleep 5

driver.find_element(:xpath, "//*[text()='17']").click
puts "From Date: January 17, 2016, chosen"


sleep 5
#to_date=driver.find_element(:css, "input[placeholder='To']")
#driver.find_element(:xpath, "//*[text()='26']").click
to_date=driver.find_element(:name, "fto")
to_date.clear
to_date.send_keys "26/01/2017"

puts "To Date: January 26 chosen"


#Location
driver.find_element(:css, "div#s2id_autogen3").click
driver.find_element(:xpath, "//*[text()='Kauai']").click
puts "Kauai is selected as Location1."


#####################################################33
# driver.find_element(:css, "div#s2id_autogen5").click
# driver.find_element(:css, "ul.select2-results")
# #driver.find_element(:css, "div.col-md-6").click
# driver.find_element(:xpath, "//*[text()='Kapaa']").click
# puts "Kapaa is selected as Location2."
######################################################

submit_button=driver.find_element(:css, "button.btn")
submit_button.click


#Asserting whether on the Tours Managements Page
pagetitle=driver.title
"Tours Management".eql?pagetitle
puts "On Tours Management Page"


##############
s
element_table = driver.find_element(:css,"table.xcrud-list")
href=element_table.find_elements(:tag_name, "href")
link=href.text


if link == tour_name
  puts 'Test passed'
else
  puts 'Test failed'
end
######################

sleep 15
#quit the driver
driver.quit