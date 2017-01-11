require "selenium-webdriver"
require "test/unit/assertions"
include Test::Unit::Assertions

driver = Selenium::WebDriver.for :firefox
#, marionette: true

driver.get "http://phptravels.net/admin"

#sleep 2
#asserting whether on phptravels admin login page
# pagetitle=driver.title
# puts assert_equal("Administator Login", pagetitle)
# puts "On Administator Login page"

driver.manage.window.maximize


#entering email
admin_email= "admin@phptravels.com"
adminEmailButton=driver.find_element(:name, "email")
adminEmailButton.send_keys admin_email
puts "admin email is " + admin_email

#entering password
admin_password="demoadmin"
adminPasswordButton=driver.find_element(:name, "password")
adminPasswordButton.send_keys admin_password
puts "admin password is " + admin_password

#clicking on Login button
loginButton = driver.find_element(:css, 'button[type="submit"]')
loginButton.click

#sleep 5
#Asserting whether on phptravels admin login page
# pagetitle=driver.title
# assert_equal("Dashboard", pagetitle)
# puts "On Dashboard"

sleep 5
#Asserting whether logged in super admin
expected_admin_name = "Super Admin"
actual_user_name=driver.find_element(:css, "div.user").text
puts actual_user_name
assert_equal(expected_admin_name, actual_user_name)
puts "Successfully logged in as Super Admin"

#sleep 5
sleep 2
#Clicking on Accounts in the sidebar menu
menucontent=driver.find_element(:id, "social-sidebar-menu")
options = menucontent.find_elements(:tag_name, 'a')
options.each { |option| option.click if option.text == 'Accounts'}

#Clicking on customers
driver.find_element(:css, "a[href='http://phptravels.net/admin/accounts/customers/']").click

sleep 4
#Asserting whether on Customers Managements Page
pagetitle=driver.title
expected_customer_mgmt = "Customers Management"
assert_equal(expected_customer_mgmt, pagetitle)
puts "On Customers Management Page"


#Clicking on add button
addButton=driver.find_element(:css, "form[action='http://phptravels.net/admin/accounts/customers/add']")
addButton.click


sleep 6

#checking if firstname field is present in the form
fname_field=driver.find_element(:name, "fname")
fname_displayed=fname_field.displayed?
if fname_displayed==true
  puts "First name field is present"
end

#entering firstname
fname_field.send_keys "Test"

#to generate unique user every time
timestamp=Time.now.to_i.to_s


#checking if lastname field is present in the form
lname_field=driver.find_element(:name, "lname")
lname_displayed=lname_field.displayed?
 if lname_displayed==true
   puts "Last name field is present"
 end

#entering lastname # unique user generated using timestamp
lname_field.send_keys "User"+timestamp


#checking if email field is present in the form
email_field=driver.find_element(:name, "email")
email_displayed=email_field.displayed?
if email_displayed==true
  puts "Email field is present"
end

#uniquie email id generated using timestamp
emailid="testuser_#{timestamp}@phptravels.com"
#emailid="testuser_"+timestamp
puts "New user generated: " + emailid
#email_field.send_keys emailid+"@phptravels.com"
email_field.send_keys emailid

#checking if password field is present in the form
password_field=driver.find_element(:name, "password")
password_field_displayed=password_field.displayed?
if password_field_displayed==true
  puts "Password field is present"
end

#entering password
password_field.send_keys "password123"

#Selecting Country
driver.find_element(:link_text, "Please Select").click
driver.find_element(:xpath, "//*[text()='United States']").click

#checking if submit button is present in the form
submit_button=driver.find_element(:css, "button.btn")
submit_button_displayed=submit_button.displayed?
if submit_button_displayed==true
  puts "Submit button is present"
end

#Clicking submit button
submit_button.click


#created_email=driver.page_source.include?emailid

sleep 5
#Asserting whether user is successfully created
created_email=driver.find_element(:xpath, ".//*[@id='content']/div/div[2]/div/div/div[1]/div[2]/table/tbody/tr[1]/td[5]/a").text
# if created_email==true
#   puts "Created Email is present"
# end

if emailid == created_email
  puts "Test passed"
else
  puts 'Test failed'
end

puts "User is successfully created."

#quit the driver
driver.quit