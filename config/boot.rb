Dir['./helpers/*.rb'].each { |helper| require helper }
require './controllers/application_controller'
Dir['./controllers/*.rb'].each { |controller| require controller }
