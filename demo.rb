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

##### assert super admin in page
#username = driver.find_element(:div, 'user')
#driver.find_element(:span, "")
#puts username


sleep 5
menucontent=driver.find_element(:id, "social-sidebar-menu")
options = menucontent.find_elements(:tag_name, 'a')
options.each { |option| option.click if option.text == 'Accounts'}


driver.find_element(:css, "a[href='http://phptravels.net/admin/accounts/customers/']").click

sleep 2

addButton=driver.find_element(:css, "form[action='http://phptravels.net/admin/accounts/customers/add']")
addButton.click

#Asserting whether on the Customer Managements Page
pagetitle=driver.title
"Customers Management".eql?pagetitle
puts "On Customers Management Page"

sleep 6
firstname=driver.find_element(:name, "fname")
firstname.send_keys "Test"

#to generate unique user every time
timestamp=Time.now.to_i.to_s
#stamp=timestamp+ [SecureRandom.hex].pack('H*').gsub(/[^0-9a-z]/i, '')


lastname=driver.find_element(:name, "lname")
lastname.send_keys "User"+timestamp

email=driver.find_element(:name, "email")
emailid="testuser"+timestamp
puts "New user generated: " + emailid
email.send_keys emailid+"@phptravels.com"

password=driver.find_element(:name, "password")
password.send_keys "password123"

driver.find_element(:link_text, "Please Select").click
driver.find_element(:xpath, "//*[text()='United States']").click

button=driver.find_element(:css, "button.btn")
button.click

#usertable=driver.find_element(:css, "table.table")

#assert driver.is_text_present emailid

####?#####s
#usertable=driver.find_element(:id, "content")
driver.page_source.include?emailid


puts "New user created: " + emailid


sleep 5
#quit the driver
driver.quit