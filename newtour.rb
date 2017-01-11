require "selenium-webdriver"
require "test/unit/assertions"
include Test::Unit::Assertions


driver = Selenium::WebDriver.for :firefox
#driver.manage.timeouts.implicit_wait = 10

driver.get "http://phptravels.net/admin"
driver.manage.window.maximize

#entering email
adminEmailButton=driver.find_element(:name, "email")
adminEmailButton.send_keys "admin@phptravels.com"

#entering password
adminPasswordButton=driver.find_element(:name, "password")
adminPasswordButton.send_keys "demoadmin"

#clicking on Login button
loginButton = driver.find_element(:css, 'button[type="submit"]')
loginButton.click

wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds

#Clicking on Tours
sleep 6
driver.find_element(:link_text, "Tours").click


#Clicking on Add new tour
sleep 5
addnew=driver.find_element(:css, "a[href='http://phptravels.net/admin/tours/add/']")
addnew.click

sleep 3
#Asserting whether on the Add Tour Page
#currentURL=driver.current_url
currentURL=wait.until{driver.current_url}

#pagetitle=driver.title
expected_url = "http://phptravels.net/admin/tours/add/"
assert_equal(expected_url, currentURL)
puts "On Add New Tour page"

#to generate unique tour name every time
timestamp=Time.now.to_i.to_s

tourname_field= wait.until{driver.find_element(:name, "tourname")}
tour_name="Kauai_"+timestamp
tourname_field.send_keys tour_name
puts "Tour name is " + tour_name

#sleep 2
#Tour description
tour_description_field=driver.find_element(:css, "iframe.cke_wysiwyg_frame")
tour_description_field.click
tour_description_field.send_keys "It is a Kauai tour."

#Quantity
quantity_field=driver.find_element(:name, "maxadult")
quantity_field.send_keys("2")
puts "Number of adult is 2"

#Price
price_field=driver.find_element(:name, "adultprice")
price_field.send_keys "$500"
puts "Adult price is $500"

#enabling
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

#driver.find_element(:xpath, "//*[text()='22']").click
from_date=driver.find_element(:name, "ffrom")
from_date.send_keys "22/01/2017"
puts "From Date: January 22, 2017"


#to_date=wait.until{driver.find_element(:name, "fto")}
to_date=driver.find_element(:name, "fto")
to_date.send_keys "26/01/2017"
puts "To Date: January 26, 2017"


#Location
driver.find_element(:css, "div#s2id_autogen3").click
driver.find_element(:xpath, "//*[text()='Kauai']").click
puts "Kauai is selected as Location1."

#clicking on submit button
submit_button=driver.find_element(:css, "button.btn")
submit_button.click

sleep 9
#Asserting whether on the Tours Managements Page
pagetitle=driver.title
expected_title = "Tours Management"
assert_equal(expected_title, pagetitle)
puts "On Tours Management Page"

created_tour_link=driver.find_element(:xpath, ".//*[@id='content']/div/div[2]/div/div/div[1]/div[2]/table/tbody/tr[1]/td[5]/a").attribute("href")
puts created_tour_link

created_tour=driver.find_element(:xpath, ".//*[@id='content']/div/div[2]/div/div/div[1]/div[2]/table/tbody/tr[1]/td[5]/a").text
#puts assert_equal(tour_name, created_tour)

 if created_tour == tour_name
   puts 'Test passed'
 else
   puts 'Test failed'
 end

puts "Tour successfully created: " + tour_name

#quit the driver
driver.quit