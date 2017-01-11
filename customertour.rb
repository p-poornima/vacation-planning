require "selenium-webdriver"
require "test/unit/assertions"
include Test::Unit::Assertions


driver = Selenium::WebDriver.for :firefox

#wait = Selenium::WebDriver::Wait.new(:timeout => 10)
#wait=driver.manage.timeouts.implicit_wait =10

#driver.get "http://phptravels.net/"
driver.get "http://phptravels.net/en"
driver.manage.window.maximize

#Asserting whether on homepage
pagetitle=driver.title
expected_homepage_title ="PHPTRAVELS | Travel Technology Partner"
assert_equal(expected_homepage_title, pagetitle)
puts "On PHPTravels home Page"

#creating a new customer account
driver.find_element(:link_text, "My Account").click
driver.find_element(:link_text, "Sign Up").click

sleep 5
#Asserting whether on register page
pagetitle=driver.title
expected_register_page ="Register"
assert_equal(expected_register_page, pagetitle)
#"Register".eql?pagetitle
puts "On register Page"

sleep 5
#entering firstname
first_name_field=driver.find_element(:name, "firstname")
firstname="Customer"
first_name_field.send_keys firstname

#to generate unique user every time
timestamp=Time.now.to_i.to_s

#entering lastname
last_name_field=driver.find_element(:name, "lastname")
lastname="TestUser_"+timestamp
last_name_field.send_keys lastname


username= "#{firstname} #{lastname}"

#entering mobile number
mobile_number=driver.find_element(:name, "phone")
mobile_number.send_keys timestamp

#entering emailid
email_field=driver.find_element(:name, "email")
#emailid="customer_"+timestamp
emailid="customer_#{timestamp}@phptravels.com"
puts "New user generated: #{username}"
email_field.send_keys emailid


#entering password
password=driver.find_element(:name, "password")
password.send_keys "password1234"

#confirming password
confirm_password=driver.find_element(:name, "confirmpassword")
confirm_password.send_keys "password1234"

#clicking on signup button
signup_button=driver.find_element(:css, "button.signupbtn")
signup_button.click


sleep 6
#Asserting whether on account page
account_pagetitle=driver.title
expected_account_pagetitle = "My Account"
assert_equal(expected_account_pagetitle, account_pagetitle)
puts "On My Account Page"

sleep 5
#Asserting if user is created successfully
welcome_text=driver.find_element(:xpath, "html/body/div[3]/div[1]/div/div[1]/h3").text
assert_equal("Hi, #{username}" , welcome_text)
puts "Welcome message displayed"

user_displayed=driver.find_element(:xpath, "html/body/div[2]/div/div/div[2]/ul[2]/li[2]/a")
driver.find_element(:link_text, firstname).displayed?
puts "User successfully created"

user_displayed.click
driver.find_element(:link_text, "Logout").displayed?
puts "Logout Button displayed"


driver.find_element(:link_text, "Tours").click

sleep 5
location=driver.find_element(:name, "txtSearch")
location.displayed?
location.click
location.send_keys "Nile"
puts "Location is Nile"

check_in_date=driver.find_element(:name, "date")
check_in_date.displayed?
puts "Check in date box displayed"
check_in_date.click
check_in_date.clear
check_in_date.send_keys "10/03/2017"
check_in_date.click
puts "Check in date is March 10, 2017."

#selecting tourtype
driver.find_element(:name, "type").click
driver.find_element(:xpath, "//*[text()='Private ']").click
puts "Private is selected as tour type."

#Clicking Search button
search_button=driver.find_element(:css, "button.btn-primary")
search_button.click

tour_details_button=driver.find_element(:css, "button.mt15")
tour_details_button.click

sleep 5
tour_details_date=driver.find_element(:name, "date")
tour_details_date.click
tour_details_date.clear
tour_details_date.send_keys "10/03/2017"
tour_details_date.click


# Clicking on "Change Date" button
buttons=driver.find_elements(:tag_name, "button")
buttons.each { |choice| choice.click if choice.text == 'Change Date'}

#clicking book now button
driver.find_element(:css, "button.btn-action").click

sleep 5
#Asserting whether on Personal information page
page_heading_text=driver.find_element(:css, "div.panel-heading").text
#puts page_heading_text
assert_equal("Personal Information", page_heading_text)
puts "On Personal Information page"

#Asserting first name on personal information page
actual_fname=driver.find_element(:xpath, ".//*[@id='loggedform']/div/div[1]/div/input").attribute("value")
assert_equal(firstname, actual_fname)

#Asserting last name on personal information page
actual_lname=driver.find_element(:xpath, ".//*[@id='loggedform']/div/div[2]/div/input").attribute("value")
assert_equal(lastname, actual_lname)

#Asserting emailid on personal information page
actual_emailid=driver.find_element(:xpath, ".//*[@id='loggedform']/div/div[3]/div/input").attribute("value")
assert_equal(emailid, actual_emailid)

#clicking Confirm Booking button
driver.find_element(:css, "button.btn").click

sleep 5
#on invoice page #asserting unpaid button
assert(driver.find_element(:css, "b.btn"))

#on invoice page
visible_text=driver.find_element(:xpath, "html/body/div[3]/div/div[7]/div[1]/div[1]").text
expected_invoice_page="INVOICE"
 if visible_text == expected_invoice_page
   puts 'Test passed'
 else
   puts 'Test failed'
 end

puts "Tour successfully booked"

#pay now
#driver.find_element(:css, "button[data-target='#paynow']").click

#quit the driver
driver.quit
