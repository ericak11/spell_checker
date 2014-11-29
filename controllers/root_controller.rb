class RootController < ApplicationController
  get('/') do
    render(:erb, :index)
  end

  post('/') do

  end
end
