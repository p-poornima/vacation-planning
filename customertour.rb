require "selenium-webdriver"

driver = Selenium::WebDriver.for :firefox, marionette: true

driver.get "http://phptravels.net/"

##assert
pagetitle=driver.title
"PHPTRAVELS | Travel Technology Partner".eql?pagetitle
puts "On PHPTravels home Page"

driver.manage.window.maximize

driver.find_element(:link_text, "My Account").click
driver.find_element(:link_text, "Sign Up").click


##assert
register_pagetitle=driver.title
"Register".eql?pagetitle
puts "On Sign Up Page"

sleep 5
firstname=driver.find_element(:name, "firstname")
firstname.send_keys "Customer"

#to generate unique user every time
timestamp=Time.now.to_i.to_s

lastname=driver.find_element(:name, "lastname")
lastname.send_keys "TestUser_"+timestamp

mobile_number=driver.find_element(:name, "phone")
mobile_number.send_keys timestamp

email=driver.find_element(:name, "email")
emailid="customer_"+timestamp
puts "New user generated: " + emailid
email.send_keys emailid+"@phptravels.com"

password=driver.find_element(:name, "password")
password.send_keys "password1234"

confirm_password=driver.find_element(:name, "confirmpassword")
confirm_password.send_keys "password1234"

signup_button=driver.find_element(:css, "button.signupbtn")
signup_button.click


##assert
account_pagetitle=driver.title
"My Account".eql?pagetitle
puts "On My Account Page"
##################
