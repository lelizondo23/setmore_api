# setmore_api

Gem for the Setmore API.

## Notes

setmore_api is a wrapper to consume the endpoints for Setmore API.

For more information of Setmore API fo to https://setmore.docs.apiary.io

## Installation
Add setmore api to gemfile.
```ruby
gem 'setmore_api', :git => 'https://github.com/lelizondo23/setmore_api.git'
```

## Configuration

You first need to get in touch with setmore support to request access to the API.

Once you get youre refresh token youre good to go.

```ruby
require 'setmore_api'

SetmoreApi.configure do |config|
  # Required refreash token
  config.refresh_token = 'refresh_token'
end
```

## Usage

### Set a fresh access token from Setmore :

```ruby
token = SetmoreApi::Token.new
#Sets the access_token and token_expire_time
#that is used to make calls to Setmore API
token.set_refreash_access_token
```
### Services

```ruby
#Get the list of all the available services provided by your company
services = SetmoreApi::Service.new
services_response = services.fetch_all
```

### Staff

```ruby
#Get a list of all available staff in your company
staff = SetmoreApi::Staff.new
staff_response = staff.fetch_all
```

### Time slots

```ruby
#Get all available time slots for the given service, staff & date for your company
#Name			Type	Required
#staff_key		String	true
#service_key	String	true
#selected_date	String	true
#off_hours		boolean	false
#double_booking	boolean	false
#slot_limit		int		false
slots = SetmoreApi::TimeSlot.new
slots_attributes =
{
  staff_key: "xxxxxxxx",
  service_key: "xxxxxxxx",
  selected_date: "dd/mm/yyyy",
  off_hours: false
}

slots_response = slots.get_all_available slots_attributes
```

### Customers

```ruby
#Create a customer

#Name				Type	Required
#first_name			String	true
#last_name			String	false
#email_id			String	false
#country_code		String	false
#cell_phone			String	false
#work_phone			String	false
#home_phone			String	false
#address			String	false
#city				String	false
#state				String	false
#postal_code		String	false
#image_url			String	false
#comment			String	false
#additional_fields	Key Value	false

customer = SetmoreApi::Customer.new
customer_params = {
 first_name: "First Name",
 last_name: "Last Name",
 email_id: "test@test.com",
 country_code: "MX",
 cell_phone: "01923409482",
 work_phone: "89123987393",
 home_phone: "12983900",
 address: "Test Address",
 city: "City",
 state: "State",
 postal_code:"60000",
 image_url: "http://placehold.it/120x120&text=image1",
 comment: "Comment"
}

new_customer = customer.create customer_params


#Get customer details
#Search users by : firstname, phone or email
get_customer_params = {
  :firstname => "firstName"
}
get_customer = customer.get_details get_customer_params
```

### Appointments

```ruby
#List appointments for a staff and date range
#Attributes for fetching appointments for a staff
#Name             Type  Required
#staff_key        String  true
#startDate        String  true
#endDate          String  true
#customerDetails  String  false (optional)
appoitnemnts = SetmoreApi::Appointment.new
staff_params = {
  staff_key: "xxxxxxxx",
  startDate: Date.today.strftime("%d-%m-%Y"),
  endDate: Date.today.strftime("%d-%m-%Y")
}
appoitnemnts.get_for_staff(staff_params)
```
